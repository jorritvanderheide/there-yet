import 'package:flutter/services.dart';
import 'package:location_alarm/shared/data/alarm_log.dart';
import 'package:location_alarm/shared/data/models/alarm.dart';

/// Manages native Android proximity alerts via LocationManager.
///
/// Proximity alerts act as a coarse "wake-up net" — the OS fires them
/// when the device enters a padded radius around the alarm location.
/// The existing GPS polling + AlarmChecker handles the precision trigger.
class ProximityAlertService {
  ProximityAlertService._();

  static const _channel = MethodChannel(
    'nl.bw20.location_alarm/proximity_alert',
  );

  static Future<void> register(AlarmData alarm) async {
    if (alarm.id == null) return;
    try {
      await _channel.invokeMethod('register', {
        'id': alarm.id,
        'lat': alarm.location.latitude,
        'lng': alarm.location.longitude,
        'radius': alarm.radius,
      });
      await AlarmLog.write(
        'Proximity registered: alarm ${alarm.id} '
        'at ${alarm.location.latitude.toStringAsFixed(5)}, '
        '${alarm.location.longitude.toStringAsFixed(5)} '
        '(radius: ${alarm.radius.round()}m, '
        'padded: ${(alarm.radius + 200).clamp(300, double.infinity).round()}m)',
      );
    } on MissingPluginException {
      // Running in a context where the channel isn't available (e.g. tests).
    } on Exception catch (e) {
      await AlarmLog.write('Proximity register failed for ${alarm.id}: $e');
    }
  }

  static Future<void> unregister(int alarmId) async {
    try {
      await _channel.invokeMethod('unregister', {'id': alarmId});
      await AlarmLog.write('Proximity unregistered: alarm $alarmId');
    } on MissingPluginException {
      // ignore
    } on Exception catch (e) {
      await AlarmLog.write('Proximity unregister failed for $alarmId: $e');
    }
  }

  static Future<void> unregisterAll() async {
    try {
      await _channel.invokeMethod('unregisterAll');
    } on MissingPluginException {
      // ignore
    } on Exception catch (e) {
      await AlarmLog.write('Proximity unregisterAll failed: $e');
    }
  }

  static Future<void> syncAll(List<AlarmData> activeAlarms) async {
    await unregisterAll();
    for (final alarm in activeAlarms) {
      await register(alarm);
    }
    if (activeAlarms.isNotEmpty) {
      await AlarmLog.write(
        'Proximity alerts synced: ${activeAlarms.length} alarm(s)',
      );
    }
  }
}
