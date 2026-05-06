import 'package:flutter/services.dart';

/// Cross-process alarm runtime state, persisted on the native side.
/// See `AlarmStateStore.kt` for the storage layout.
class AlarmStateStore {
  AlarmStateStore._();

  static const _channel = MethodChannel('nl.bw20.there_yet/alarm_state');

  /// Mark an alarm as currently ringing.
  static Future<void> markRinging(int alarmId) async {
    try {
      await _channel.invokeMethod('addRinging', {'id': alarmId});
    } on MissingPluginException {
      // ignore
    } on Exception {
      // ignore
    }
  }

  /// Clear the ringing flag for an alarm.
  static Future<void> unmarkRinging(int alarmId) async {
    try {
      await _channel.invokeMethod('removeRinging', {'id': alarmId});
    } on MissingPluginException {
      // ignore
    } on Exception {
      // ignore
    }
  }

  /// IDs of alarms currently ringing.
  static Future<List<int>> getRinging() async {
    try {
      final result = await _channel.invokeMethod<List<Object?>>('getRinging');
      return result?.cast<int>() ?? const [];
    } on MissingPluginException {
      return const [];
    } on Exception {
      return const [];
    }
  }

  /// Returns alarm IDs that were dismissed via notification while the FGS
  /// was unreachable, and clears the list. Caller must write `active=false`
  /// for each ID.
  static Future<List<int>> consumePendingDismisses() async {
    try {
      final result = await _channel.invokeMethod<List<Object?>>(
        'consumePendingDismiss',
      );
      return result?.cast<int>() ?? const [];
    } on MissingPluginException {
      return const [];
    } on Exception {
      return const [];
    }
  }
}
