import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final locationPermissionProvider =
    NotifierProvider<LocationPermissionNotifier, PermissionStatus>(
      LocationPermissionNotifier.new,
    );

/// `null` = not checked yet, `true`/`false` = checked result.
final backgroundPermissionProvider = NotifierProvider<_BoolPermNotifier, bool?>(
  _BoolPermNotifier.new,
);

/// `null` = not checked yet, `true`/`false` = checked result.
final notificationPermissionProvider =
    NotifierProvider<_BoolPermNotifier, bool?>(_BoolPermNotifier.new);

/// `null` = not checked yet, `true`/`false` = checked result.
final batteryOptimizationProvider = NotifierProvider<_BoolPermNotifier, bool?>(
  _BoolPermNotifier.new,
);

class _BoolPermNotifier extends Notifier<bool?> {
  @override
  bool? build() => null;

  void set(bool value) => state = value;
}

class LocationPermissionNotifier extends Notifier<PermissionStatus> {
  @override
  PermissionStatus build() {
    _init();
    return PermissionStatus.denied;
  }

  Future<void> _init() async {
    state = await Permission.locationWhenInUse.status;
    ref
        .read(backgroundPermissionProvider.notifier)
        .set((await Permission.locationAlways.status).isGranted);
    ref
        .read(notificationPermissionProvider.notifier)
        .set((await Permission.notification.status).isGranted);
    ref
        .read(batteryOptimizationProvider.notifier)
        .set(await Permission.ignoreBatteryOptimizations.isGranted);
  }

  Future<void> checkAll() async {
    state = await Permission.locationWhenInUse.status;
    ref
        .read(backgroundPermissionProvider.notifier)
        .set((await Permission.locationAlways.status).isGranted);
    ref
        .read(notificationPermissionProvider.notifier)
        .set((await Permission.notification.status).isGranted);
    ref
        .read(batteryOptimizationProvider.notifier)
        .set(await Permission.ignoreBatteryOptimizations.isGranted);
  }

  Future<void> request() async {
    state = await Permission.locationWhenInUse.request();
  }

  /// Requests background location. Returns true if granted.
  Future<bool> requestBackground() async {
    if ((await Permission.locationAlways.status).isGranted) {
      ref.read(backgroundPermissionProvider.notifier).set(true);
      return true;
    }

    final foreground = await Permission.locationWhenInUse.status;
    if (!foreground.isGranted) {
      state = await Permission.locationWhenInUse.request();
      if (!state.isGranted) return false;
    }
    final result = await Permission.locationAlways.request();
    ref.read(backgroundPermissionProvider.notifier).set(result.isGranted);
    return result.isGranted;
  }

  /// Requests notification permission. Returns true if granted.
  Future<bool> requestNotification() async {
    final result = await Permission.notification.request();
    ref.read(notificationPermissionProvider.notifier).set(result.isGranted);
    return result.isGranted;
  }

  /// Requests battery optimization exemption. Returns true if granted.
  Future<bool> requestBatteryOptimization() async {
    final result = await Permission.ignoreBatteryOptimizations.request();
    final granted = result.isGranted;
    ref.read(batteryOptimizationProvider.notifier).set(granted);
    return granted;
  }
}
