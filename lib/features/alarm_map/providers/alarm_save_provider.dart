import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:there_yet/features/alarm_service/providers/alarm_service_provider.dart';
import 'package:there_yet/shared/data/alarm_thumbnail.dart';
import 'package:there_yet/shared/data/geo_utils.dart';
import 'package:there_yet/shared/data/models/alarm.dart';
import 'package:there_yet/shared/providers/alarm_repository_provider.dart';
import 'package:there_yet/shared/providers/connectivity_provider.dart';
import 'package:there_yet/shared/providers/geocoding_provider.dart';
import 'package:there_yet/shared/providers/location_permission_provider.dart';
import 'package:there_yet/shared/providers/location_provider.dart';
import 'package:permission_handler/permission_handler.dart';

final alarmSaveProvider = NotifierProvider<AlarmSaveNotifier, AlarmSaveState>(
  AlarmSaveNotifier.new,
);

sealed class AlarmSaveState {
  const AlarmSaveState();
}

final class AlarmSaveIdle extends AlarmSaveState {
  const AlarmSaveIdle();
}

final class AlarmSaveBusy extends AlarmSaveState {
  const AlarmSaveBusy();
}

/// Provider pauses, UI should show rationale dialog and call [AlarmSaveNotifier.confirmStep].
final class AlarmSaveNeedsConfirmation extends AlarmSaveState {
  const AlarmSaveNeedsConfirmation(this.step);
  final SaveConfirmationStep step;
}

sealed class SaveConfirmationStep {
  const SaveConfirmationStep();
}

final class BackgroundLocationRationale extends SaveConfirmationStep {
  const BackgroundLocationRationale();
}

final class BatteryOptimizationRationale extends SaveConfirmationStep {
  const BatteryOptimizationRationale();
}

final class InsideRadiusWarning extends SaveConfirmationStep {
  const InsideRadiusWarning();
}

/// Provider pauses, UI should capture map thumbnail and call [AlarmSaveNotifier.provideThumbnail].
final class AlarmSaveNeedsThumbnail extends AlarmSaveState {
  const AlarmSaveNeedsThumbnail();
}

final class AlarmSaveNotificationDenied extends AlarmSaveState {
  const AlarmSaveNotificationDenied();
}

/// The kind of "saved" outcome to display. The UI maps each to an l10n key.
enum AlarmSavedKind {
  /// Saved and active.
  regular,

  /// Saved inactive because no GPS lock was available.
  noGps,

  /// Saved inactive because the user is currently inside the radius.
  inside,
}

final class AlarmSaved extends AlarmSaveState {
  const AlarmSaved({required this.name, required this.kind});

  /// Display name to substitute into the localized message. Empty if the
  /// alarm has neither a user-supplied label nor a reverse-geocoded name;
  /// callers should fall back to a localized default.
  final String name;
  final AlarmSavedKind kind;
}

sealed class AlarmSaveError {
  const AlarmSaveError();
}

final class AlarmSaveErrorLocationDenied extends AlarmSaveError {
  const AlarmSaveErrorLocationDenied();
}

final class AlarmSaveErrorBackgroundDenied extends AlarmSaveError {
  const AlarmSaveErrorBackgroundDenied();
}

/// Unexpected failure. Technical details are logged; the user only sees a
/// generic message.
final class AlarmSaveErrorUnknown extends AlarmSaveError {
  const AlarmSaveErrorUnknown();
}

final class AlarmSaveFailed extends AlarmSaveState {
  const AlarmSaveFailed(this.error);
  final AlarmSaveError error;
}

class AlarmSaveNotifier extends Notifier<AlarmSaveState> {
  int? _alarmId;
  String _name = '';
  LatLng? _location;
  double _radius = 500;
  Uint8List? _thumbnail;

  @override
  AlarmSaveState build() => const AlarmSaveIdle();

  void reset() => state = const AlarmSaveIdle();

  Future<void> save({
    required int? alarmId,
    required String name,
    required LatLng location,
    required double radius,
  }) async {
    if (state is! AlarmSaveIdle) return;
    _alarmId = alarmId;
    _name = name;
    _location = location;
    _radius = radius;
    _thumbnail = null;

    state = const AlarmSaveBusy();

    final fgStatus = await Permission.locationWhenInUse.status;
    if (!fgStatus.isGranted) {
      await ref.read(locationPermissionProvider.notifier).request();
      if (ref.read(locationPermissionProvider) != PermissionStatus.granted) {
        state = const AlarmSaveFailed(AlarmSaveErrorLocationDenied());
        return;
      }
    }

    if (!(await Permission.locationAlways.status).isGranted) {
      state = const AlarmSaveNeedsConfirmation(BackgroundLocationRationale());
      return;
    }

    await _continueAfterBackground();
  }

  /// Called by UI after background location rationale dialog.
  Future<void> confirmStep(bool confirmed) async {
    if (state is! AlarmSaveNeedsConfirmation) return;
    final step = (state as AlarmSaveNeedsConfirmation).step;

    state = const AlarmSaveBusy();

    switch (step) {
      case BackgroundLocationRationale():
        if (!confirmed) {
          state = const AlarmSaveFailed(AlarmSaveErrorBackgroundDenied());
          return;
        }
        final granted = await ref
            .read(locationPermissionProvider.notifier)
            .requestBackground();
        if (!granted) {
          state = const AlarmSaveFailed(AlarmSaveErrorBackgroundDenied());
          return;
        }
        await _continueAfterBackground();

      case BatteryOptimizationRationale():
        if (confirmed) {
          await ref
              .read(locationPermissionProvider.notifier)
              .requestBatteryOptimization();
        }
        await _continueAfterBattery();

      case InsideRadiusWarning():
        if (!confirmed) {
          state = const AlarmSaveIdle();
          return;
        }
        await _continueAfterInsideRadius();
    }
  }

  Future<void> _continueAfterBackground() async {
    final notifGranted = await ref
        .read(locationPermissionProvider.notifier)
        .requestNotification();
    if (!notifGranted) {
      // Block save: without notifications the alarm may fire but the user
      // has no reliable way to see or dismiss it. The UI will surface a
      // CTA to grant the permission and the user can retry saving.
      state = const AlarmSaveNotificationDenied();
      return;
    }

    if (!(await Permission.ignoreBatteryOptimizations.isGranted)) {
      state = const AlarmSaveNeedsConfirmation(BatteryOptimizationRationale());
      return;
    }

    await _continueAfterBattery();
  }

  Future<void> _continueAfterBattery() async {
    state = const AlarmSaveNeedsThumbnail();
  }

  /// Called by UI after capturing the map thumbnail.
  Future<void> provideThumbnail(Uint8List? thumbnail) async {
    _thumbnail = thumbnail;
    state = const AlarmSaveBusy();

    final position = ref.read(locationProvider).whenData((p) => p).value;
    final hasLocationLock = position != null;
    final isInsideRadius =
        hasLocationLock &&
        distanceInMeters(
              LatLng(position.latitude, position.longitude),
              _location!,
            ) <=
            _radius;

    if (isInsideRadius) {
      state = const AlarmSaveNeedsConfirmation(InsideRadiusWarning());
      return;
    }

    await _writeAlarm(
      active: hasLocationLock && !isInsideRadius,
      hasLocationLock: hasLocationLock,
      isInsideRadius: isInsideRadius,
    );
  }

  Future<void> _continueAfterInsideRadius() async {
    await _writeAlarm(
      active: false,
      hasLocationLock: true,
      isInsideRadius: true,
    );
  }

  Future<void> _writeAlarm({
    required bool active,
    required bool hasLocationLock,
    required bool isInsideRadius,
  }) async {
    try {
      final isOnline = ref.read(connectivityProvider);
      var locationName = '';
      if (isOnline) {
        final geocodingRepo = ref.read(geocodingRepositoryProvider);
        locationName =
            await geocodingRepo.reverseGeocode(_location!, radius: _radius) ??
            '';
      }
      final alarmName = _name.isEmpty ? locationName : _name;

      final alarm = AlarmData(
        id: _alarmId,
        name: alarmName,
        location: _location!,
        active: active,
        radius: _radius,
        locationName: locationName,
      );

      if (_thumbnail != null && _alarmId != null) {
        try {
          await AlarmThumbnail.save(_alarmId!, _thumbnail!);
        } on Exception catch (e) {
          debugPrint('[alarm_save] thumbnail save failed: $e');
        }
      }

      final repo = ref.read(alarmRepositoryProvider);
      final savedId = await repo.save(alarm);
      AlarmServiceNotifier.refresh();

      if (_thumbnail != null && _alarmId == null) {
        try {
          await AlarmThumbnail.save(savedId, _thumbnail!);
        } on Exception catch (e) {
          debugPrint('[alarm_save] thumbnail save failed: $e');
        }
      }

      // Use the saved name (which falls back to the reverse-geocoded
      // location). UI substitutes a localized "Alarm" if both are empty.
      final AlarmSavedKind kind;
      if (!hasLocationLock) {
        kind = AlarmSavedKind.noGps;
      } else if (isInsideRadius) {
        kind = AlarmSavedKind.inside;
      } else {
        kind = AlarmSavedKind.regular;
      }

      state = AlarmSaved(name: alarmName, kind: kind);
    } on Exception catch (e) {
      debugPrint('[alarm_save] failed: $e');
      state = const AlarmSaveFailed(AlarmSaveErrorUnknown());
    }
  }
}
