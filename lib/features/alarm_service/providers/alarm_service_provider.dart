import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:there_yet/shared/data/models/alarm.dart';
import 'package:there_yet/shared/providers/alarm_repository_provider.dart';
import 'package:there_yet/shared/providers/alarms_provider.dart';

const _notificationChannel = MethodChannel(
  'nl.bw20.there_yet/alarm_notification',
);

final alarmServiceProvider =
    NotifierProvider<AlarmServiceNotifier, List<AlarmData>>(
      AlarmServiceNotifier.new,
    );

/// Relays alarm-fire events from the background isolate to the UI.
///
/// State is the list of currently ringing alarms (empty when idle).
class AlarmServiceNotifier extends Notifier<List<AlarmData>> {
  @override
  List<AlarmData> build() {
    FlutterForegroundTask.addTaskDataCallback(_onTaskData);

    ref.onDispose(() {
      FlutterForegroundTask.removeTaskDataCallback(_onTaskData);
    });

    return [];
  }

  Future<void> _onTaskData(Object data) async {
    if (data is! String) return;

    final json = jsonDecode(data) as Map<String, dynamic>;
    final type = json['type'] as String?;

    if (type == 'alarm_fired') {
      final id = json['id'] as int;
      if (state.any((a) => a.id == id)) return;
      final alarms = ref.read(alarmsProvider).whenData((a) => a).value;
      final alarm = alarms?.where((a) => a.id == id).firstOrNull;
      if (alarm != null) {
        state = [...state, alarm];
      }
    } else if (type == 'alarm_dismissed') {
      // Background isolate already wrote active=false to its DB connection.
      // Invalidate the alarms provider so the main isolate's DB connection
      // re-reads the updated state.
      final id = json['id'] as int;
      state = state.where((a) => a.id != id).toList();
      ref.invalidate(alarmsProvider);
    }
  }

  /// Dismiss a ringing alarm.
  ///
  /// The main isolate writes `active=false` directly so the `alarmsProvider`
  /// stream (bound to the main Drift instance) emits immediately. The BG
  /// isolate message is still needed to stop the alarm audio and reset its
  /// internal fired-ids set; its idempotent write is a safety net.
  Future<void> dismiss(int alarmId) async {
    try {
      await ref
          .read(alarmRepositoryProvider)
          .toggleActive(alarmId, active: false);
    } on Exception {
      // Best-effort; BG isolate writes as a fallback below.
    }

    FlutterForegroundTask.sendDataToTask(
      jsonEncode({'type': 'dismiss', 'id': alarmId}),
    );
    try {
      await _notificationChannel.invokeMethod('dismissAlarm', {
        'alarmId': alarmId,
      });
    } on MissingPluginException {
      // Channel may not be available yet
    }
    state = state.where((a) => a.id != alarmId).toList();
  }

  /// Tell the background isolate to re-check alarms immediately.
  static void refresh() {
    FlutterForegroundTask.sendDataToTask(jsonEncode({'type': 'refresh'}));
  }
}
