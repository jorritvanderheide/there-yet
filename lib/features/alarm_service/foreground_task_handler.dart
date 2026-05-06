import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:there_yet/features/alarm_service/alarm_checker.dart';
import 'package:there_yet/features/alarm_service/alarm_state_store.dart';
import 'package:there_yet/features/alarm_service/background_alarm_player.dart';
import 'package:there_yet/features/alarm_service/proximity_alert_service.dart';
import 'package:there_yet/shared/data/database/app_database.dart';
import 'package:there_yet/shared/data/geo_utils.dart';
import 'package:there_yet/shared/data/database/connection.dart';
import 'package:there_yet/shared/data/repositories/alarm_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
void startCallback() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterForegroundTask.setTaskHandler(LocationTaskHandler());
}

class LocationTaskHandler extends TaskHandler {
  StreamSubscription<Position>? _positionSub;

  AppDatabase? _db;
  AlarmRepository? _repo;
  final _checker = AlarmChecker();
  final _player = BackgroundAlarmPlayer();
  final Set<int> _firedIds = {};
  bool _ready = false;

  // Position tracking: deduplicate checks.
  LatLng? _lastPosition;
  DateTime? _lastCheckTime;
  double _lastAccuracy = 0;

  // Speed tracking for adaptive polling.
  LatLng? _previousPosition;
  DateTime? _previousPositionTime;
  double _speedMps = 0; // meters per second

  Timer? _adaptivePollTimer;

  int _resubscribeAttempts = 0;
  bool _fetchInFlight = false;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    try {
      _db = openDatabase();
      _repo = AlarmRepository(_db!);
      _ready = true;
    } on Exception catch (e) {
      debugPrint('[alarm_service] DB open failed: $e');
      return;
    }

    // Apply dismisses that happened while the FGS was dead, and seed
    // `_firedIds` so an already-ringing alarm doesn't refire on this position
    // check. Both must happen before `_fetchPosition`, which calls
    // `_checkAlarms`.
    await _applyPendingDismisses();
    await _seedFiredIds();

    _startPositionStream();
    await _fetchPosition(source: 'init');
    await _reregisterProximityAlertsIfNeeded();
  }

  Future<void> _applyPendingDismisses() async {
    final ids = await AlarmStateStore.consumePendingDismisses();
    for (final id in ids) {
      try {
        await _repo!.toggleActive(id, active: false);
        _firedIds.remove(id);
      } on Exception catch (e) {
        debugPrint('[alarm_service] writeback dismiss $id failed: $e');
      }
    }
  }

  Future<void> _seedFiredIds() async {
    final ids = await AlarmStateStore.getRinging();
    _firedIds.addAll(ids);
  }

  void _startPositionStream() {
    _positionSub?.cancel();
    _positionSub =
        Geolocator.getPositionStream(
          locationSettings: AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 0,
            intervalDuration: const Duration(seconds: 10),
            forceLocationManager: true,
          ),
        ).listen(
          _onStreamPosition,
          onError: (Object _) {
            _resubscribeAfterDelay();
          },
        );
  }

  /// Fetches a single position fix. Retries up to 3 times on failure.
  /// Skipped if a previous fetch is still in flight, since slow GPS plus
  /// overlapping triggers (stream, adaptive timer, repeat event) can otherwise
  /// stack multiple concurrent requests.
  Future<void> _fetchPosition({required String source}) async {
    if (_fetchInFlight) return;
    _fetchInFlight = true;
    try {
      for (var attempt = 0; attempt < 3; attempt++) {
        try {
          final timeout = Duration(seconds: 15 + attempt * 10);
          final pos = await Geolocator.getCurrentPosition(
            locationSettings: AndroidSettings(
              accuracy: LocationAccuracy.high,
              timeLimit: timeout,
              forceLocationManager: true,
            ),
          );
          await _processPosition(pos, source: source);
          return;
        } on Exception catch (e) {
          debugPrint(
            '[alarm_service] fetch($source) attempt ${attempt + 1} failed: $e',
          );
        }
      }
    } finally {
      _fetchInFlight = false;
    }
  }

  /// Central position handler. Both stream and poll positions flow through
  /// here. Deduplicates checks and tracks speed.
  Future<void> _processPosition(Position pos, {required String source}) async {
    if (!_ready) return;

    final latLng = LatLng(pos.latitude, pos.longitude);
    final now = DateTime.now();

    // Skip check if position hasn't meaningfully changed.
    if (_lastPosition != null && _lastCheckTime != null) {
      final moved = distanceInMeters(_lastPosition!, latLng);
      final elapsed = now.difference(_lastCheckTime!).inSeconds;
      if (moved < max(10, pos.accuracy) && elapsed < 5) {
        return;
      }
    }

    // Update speed estimate.
    if (_previousPosition != null && _previousPositionTime != null) {
      final dt = now.difference(_previousPositionTime!).inMilliseconds / 1000;
      if (dt > 0.5) {
        final dist = distanceInMeters(_previousPosition!, latLng);
        _speedMps = dist / dt;
      }
    }
    _previousPosition = latLng;
    _previousPositionTime = now;

    _lastPosition = latLng;
    _lastAccuracy = pos.accuracy;
    _lastCheckTime = now;

    FlutterForegroundTask.sendDataToMain(
      jsonEncode({
        'type': 'position',
        'lat': latLng.latitude,
        'lng': latLng.longitude,
      }),
    );

    await _checkAlarms(latLng);
    _scheduleAdaptivePoll();
  }

  void _onStreamPosition(Position position) {
    _resubscribeAttempts = 0;
    _processPosition(position, source: 'stream');
  }

  void _resubscribeAfterDelay() {
    final exponent = _resubscribeAttempts.clamp(0, 4);
    final seconds = (30 * (1 << exponent)).clamp(30, 480);
    _resubscribeAttempts++;
    Future<void>.delayed(Duration(seconds: seconds), () {
      if (!_ready) return;
      _startPositionStream();
    });
  }

  /// Re-register proximity alerts after a device reboot.
  Future<void> _reregisterProximityAlertsIfNeeded() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final needsReregister =
          prefs.getBool('proximity_needs_reregister') ?? false;
      if (!needsReregister) return;

      final active = await _repo!.getActive();
      await ProximityAlertService.syncAll(active);
      // Clear the flag only after successful re-registration so a transient
      // failure doesn't leave the device without OS-level wake-ups.
      await prefs.setBool('proximity_needs_reregister', false);
    } on Exception catch (e) {
      debugPrint('[alarm_service] proximity re-register failed: $e');
    }
  }

  /// Compute the adaptive poll interval based on speed and distance to
  /// the nearest alarm.
  void _scheduleAdaptivePoll() {
    final pos = _lastPosition;
    if (pos == null) return;

    _repo?.getActive().then((alarms) {
      var intervalSeconds = 60;

      final checkable = alarms.where((a) => !_firedIds.contains(a.id));
      if (checkable.isNotEmpty) {
        final minDist = checkable
            .map((a) => distanceInMeters(pos, a.location))
            .fold<double>(double.infinity, min);

        if (_speedMps > 1) {
          final eta = minDist / _speedMps;
          intervalSeconds = (eta / 3).clamp(5, 60).round();
        } else if (minDist < 500) {
          intervalSeconds = 10;
        } else if (minDist < 2000) {
          intervalSeconds = 30;
        }
      }

      _adaptivePollTimer?.cancel();
      _adaptivePollTimer = Timer(Duration(seconds: intervalSeconds), () {
        if (_ready) _fetchPosition(source: 'adaptive');
      });
    });
  }

  Future<void> _checkAlarms(LatLng position) async {
    try {
      final activeAlarms = await _repo!.getActive();

      final activeIds = activeAlarms.map((a) => a.id!).toSet();
      final droppedIds = _firedIds.difference(activeIds);
      _firedIds.retainAll(activeIds);
      for (final id in droppedIds) {
        await AlarmStateStore.unmarkRinging(id);
      }

      final checkable = activeAlarms
          .where((a) => !_firedIds.contains(a.id))
          .toList();

      final triggered = _checker.check(
        checkable,
        position,
        accuracy: _lastAccuracy,
      );

      for (final alarm in triggered) {
        _firedIds.add(alarm.id!);
        await AlarmStateStore.markRinging(alarm.id!);

        FlutterForegroundTask.sendDataToMain(
          jsonEncode({'type': 'alarm_fired', 'id': alarm.id}),
        );

        await _player.fire(alarm);
      }
    } on Exception catch (e) {
      debugPrint('[alarm_service] check failed: $e');
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    if (!_ready) return;
    _fetchPosition(source: 'poll');
  }

  @override
  void onReceiveData(Object data) {
    if (data is! String) return;
    _handleData(data);
  }

  Future<void> _handleData(String data) async {
    try {
      final json = jsonDecode(data) as Map<String, dynamic>;
      final type = json['type'] as String?;

      if (type == 'dismiss') {
        final id = json['id'] as int;
        await _player.stop(alarmId: id);
        await _repo?.toggleActive(id, active: false);
        _firedIds.remove(id);
        await AlarmStateStore.unmarkRinging(id);
        FlutterForegroundTask.sendDataToMain(
          jsonEncode({'type': 'alarm_dismissed', 'id': id}),
        );
      } else if (type == 'proximity_wake') {
        await _fetchPosition(source: 'proximity');
      } else if (type == 'refresh') {
        final position = _lastPosition;
        if (position != null) {
          await _checkAlarms(position);
        }
      }
    } on Exception catch (e) {
      debugPrint('[alarm_service] handleData failed: $e');
    }
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    _ready = false;
    _adaptivePollTimer?.cancel();
    await _positionSub?.cancel();
    await _player.stop();
    await _player.dispose();
    await _db?.close();
  }
}
