import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart';
import 'package:location_alarm/shared/data/models/alarm.dart';

const _notificationChannel = MethodChannel(
  'nl.bw20.location_alarm/alarm_notification',
);
const _ringtoneChannel = MethodChannel('nl.bw20.location_alarm/ringtone');

/// Isolate-safe alarm player — works from the foreground service's background
/// isolate as well as the main isolate.
class BackgroundAlarmPlayer {
  AudioPlayer? _audioPlayer;

  /// Initialize the audio player.
  /// Must be called after the Flutter binding is initialized.
  Future<void> init() async {
    _audioPlayer = AudioPlayer();
  }

  /// Fire an alarm — play looping audio, vibrate, show notification.
  Future<void> fire(AlarmData alarm) async {
    if (alarm.id == null) return;

    // Start looping audio in the background — don't block notification.
    // audioplayers' play() may not complete with loop mode, so we fire and
    // forget to avoid blocking the notification path.
    unawaited(_playLoop());

    final label = alarm.name.isNotEmpty ? alarm.name : null;
    final title = label ?? 'Location Alarm';
    final body = 'You are within ${alarm.radius.round()} m of your destination';

    // Show notification via native Android method channel
    try {
      await _notificationChannel.invokeMethod('showAlarm', {
        'alarmId': alarm.id,
        'title': title,
        'body': body,
      });
    } on Exception catch (e) {
      debugPrint('ALARM: notification failed: $e');
    }
  }

  Future<void> _playLoop() async {
    try {
      await _audioPlayer?.setAudioContext(
        AudioContext(
          android: const AudioContextAndroid(
            audioFocus: AndroidAudioFocus.gain,
            usageType: AndroidUsageType.alarm,
            contentType: AndroidContentType.sonification,
          ),
          iOS: AudioContextIOS(),
        ),
      );
      await _audioPlayer?.setReleaseMode(ReleaseMode.loop);

      // Try the system alarm sound first, fall back to bundled asset.
      Source source = AssetSource('alarm.wav');
      try {
        final uri = await _ringtoneChannel.invokeMethod<String>('getAlarmUri');
        if (uri != null && uri.isNotEmpty) {
          source = UrlSource(uri);
        }
      } on MissingPluginException {
        // Background isolate may not have the channel — use asset.
      }

      await _audioPlayer?.play(source, volume: 1.0);
    } on Exception catch (e) {
      debugPrint('ALARM: audio playback failed: $e');
    }
    try {
      await HapticFeedback.vibrate();
    } on Exception {
      // Not available in background isolate
    }
  }

  /// Stop the currently ringing alarm.
  Future<void> stop() async {
    try {
      await _audioPlayer?.stop();
    } on Exception catch (e) {
      debugPrint('ALARM: audio stop failed: $e');
    }
    try {
      await _notificationChannel.invokeMethod('dismissAlarm');
    } on Exception catch (e) {
      debugPrint('ALARM: notification dismiss failed: $e');
    }
  }

  /// Release resources.
  Future<void> dispose() async {
    try {
      await _audioPlayer?.dispose();
    } on Exception catch (e) {
      debugPrint('ALARM: audio dispose failed: $e');
    }
  }
}
