import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_alarm/features/alarm_service/alarm_checker.dart';
import 'package:location_alarm/features/alarm_service/background_alarm_player.dart';
import 'package:location_alarm/shared/data/database/app_database.dart';
import 'package:location_alarm/shared/data/database/connection.dart';
import 'package:location_alarm/shared/data/repositories/alarm_repository.dart';

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
  LatLng? _lastPosition;
  bool _ready = false;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    try {
      _db = openDatabase();
      _repo = AlarmRepository(_db!);
      await _player.init();
      _ready = true;
    } on Exception catch (e) {
      debugPrint('ALARM: failed to initialize background task: $e');
      return;
    }

    _positionSub =
        Geolocator.getPositionStream(
          locationSettings: AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
            forceLocationManager: true,
          ),
        ).listen(
          _onPosition,
          onError: (Object e) {
            debugPrint('ALARM: position stream error: $e');
          },
        );
  }

  Future<void> _onPosition(Position position) async {
    if (!_ready) return;

    final latLng = LatLng(position.latitude, position.longitude);
    _lastPosition = latLng;

    FlutterForegroundTask.sendDataToMain(
      jsonEncode({
        'type': 'position',
        'lat': latLng.latitude,
        'lng': latLng.longitude,
      }),
    );

    await _checkAlarms(latLng);
  }

  Future<void> _checkAlarms(LatLng position) async {
    try {
      final activeAlarms = await _repo!.getActive();

      final activeIds = activeAlarms.map((a) => a.id!).toSet();
      _firedIds.retainAll(activeIds);

      final checkable = activeAlarms
          .where((a) => !_firedIds.contains(a.id))
          .toList();
      final triggered = _checker.check(checkable, position);

      for (final alarm in triggered) {
        _firedIds.add(alarm.id!);

        // Notify main isolate first so dismiss screen shows regardless
        // of whether audio/notification succeeds
        FlutterForegroundTask.sendDataToMain(
          jsonEncode({'type': 'alarm_fired', 'id': alarm.id}),
        );

        await _player.fire(alarm);
      }
    } on Exception catch (e) {
      debugPrint('ALARM: error checking alarms: $e');
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    if (!_ready) return;
    final position = _lastPosition;
    if (position != null) {
      _checkAlarms(position);
    }
  }

  @override
  void onReceiveData(Object data) {
    if (data is! String) return;

    try {
      final json = jsonDecode(data) as Map<String, dynamic>;
      final type = json['type'] as String?;

      if (type == 'dismiss') {
        final id = json['id'] as int;
        _player.stop();
        _firedIds.remove(id);
        _repo?.toggleActive(id, active: false);
        FlutterForegroundTask.sendDataToMain(
          jsonEncode({'type': 'alarm_dismissed', 'id': id}),
        );
      } else if (type == 'refresh') {
        final position = _lastPosition;
        if (position != null) {
          _checkAlarms(position);
        }
      }
    } on Exception catch (e) {
      debugPrint('ALARM: error handling received data: $e');
    }
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    await _positionSub?.cancel();
    await _player.stop();
    await _player.dispose();
    await _db?.close();
  }
}
