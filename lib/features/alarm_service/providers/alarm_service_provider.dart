import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_alarm/shared/data/models/alarm.dart';
import 'package:location_alarm/shared/providers/alarm_repository_provider.dart';
import 'package:location_alarm/shared/providers/alarms_provider.dart';

const _notificationChannel = MethodChannel(
  'nl.bw20.location_alarm/alarm_notification',
);

final alarmServiceProvider = NotifierProvider<AlarmServiceNotifier, AlarmData?>(
  AlarmServiceNotifier.new,
);

/// Relays alarm-fire events from the background isolate to the UI.
///
/// State is the currently ringing [AlarmData], or `null` when idle.
class AlarmServiceNotifier extends Notifier<AlarmData?> {
  @override
  AlarmData? build() {
    FlutterForegroundTask.addTaskDataCallback(_onTaskData);

    ref.onDispose(() {
      FlutterForegroundTask.removeTaskDataCallback(_onTaskData);
    });

    return null;
  }

  Future<void> _onTaskData(Object data) async {
    if (data is! String) return;

    final json = jsonDecode(data) as Map<String, dynamic>;
    final type = json['type'] as String?;

    if (type == 'alarm_fired') {
      final id = json['id'] as int;
      final alarms = ref.read(alarmsProvider).whenData((a) => a).value;
      final alarm = alarms?.where((a) => a.id == id).firstOrNull;
      if (alarm != null) {
        state = alarm;
      }
    } else if (type == 'alarm_dismissed') {
      final id = json['id'] as int;
      // Deactivate via main isolate's DB connection so alarmsProvider updates
      await ref.read(alarmRepositoryProvider).toggleActive(id, active: false);
      if (state?.id == id) {
        state = null;
      }
    }
  }

  /// Dismiss the currently ringing alarm by sending a command to the
  /// background isolate.
  Future<void> dismiss(int alarmId) async {
    FlutterForegroundTask.sendDataToTask(
      jsonEncode({'type': 'dismiss', 'id': alarmId}),
    );
    // Deactivate via main isolate's DB so alarmsProvider updates
    await ref
        .read(alarmRepositoryProvider)
        .toggleActive(alarmId, active: false);
    // Cancel notification from main isolate
    try {
      await _notificationChannel.invokeMethod('dismissAlarm');
    } on MissingPluginException {
      // Channel may not be available yet
    }
    state = null;
  }
}
