import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_alarm/app.dart';
import 'package:location_alarm/features/alarm_service/foreground_service_manager.dart';
import 'package:location_alarm/features/alarm_service/providers/alarm_service_provider.dart';
import 'package:location_alarm/features/alarm_service/providers/foreground_service_provider.dart';
import 'package:location_alarm/features/alarm_service/screens/alarm_ring_screen.dart';
import 'package:location_alarm/shared/data/database/connection.dart';
import 'package:location_alarm/shared/data/models/alarm.dart';
import 'package:location_alarm/shared/providers/database_provider.dart';
import 'package:location_alarm/shared/providers/preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _screenChannel = MethodChannel('nl.bw20.location_alarm/screen');

Future<bool> _isScreenOff() async {
  try {
    final result = await _screenChannel.invokeMethod<bool>('isScreenOff');
    return result ?? true;
  } on MissingPluginException {
    return true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = openDatabase();
  final prefs = await SharedPreferences.getInstance();

  ForegroundServiceManager.init();
  FlutterForegroundTask.initCommunicationPort();

  // Clear any leftover lock screen flags
  try {
    await _screenChannel.invokeMethod('clearLockScreenFlags');
  } on MissingPluginException {
    // ignore
  }

  final container = ProviderContainer(
    overrides: [
      databaseProvider.overrideWithValue(db),
      preferencesProvider.overrideWithValue(prefs),
    ],
  );

  bool dismissScreenShowing = false;

  // Listen for alarm fires from the background isolate via the provider
  container.listen(alarmServiceProvider, (previous, next) {
    if (next == null) return;

    // Show full-screen dismiss when screen is off
    _showDismissScreenIfNeeded(
      next,
      isDismissShowing: () => dismissScreenShowing,
      setDismissShowing: (value) => dismissScreenShowing = value,
    );
  });

  // Check if launched via full-screen alarm intent (screen off case)
  unawaited(
    _checkLaunchIntent(() {
      if (!dismissScreenShowing) {
        dismissScreenShowing = true;
        return () => dismissScreenShowing = false;
      }
      return null;
    }),
  );

  // Listen for alarm intents arriving while the app is already running
  _screenChannel.setMethodCallHandler((call) async {
    if (call.method == 'onAlarmRing') {
      final args = call.arguments as Map<Object?, Object?>;
      final alarmId = args['alarm_id'] as int?;
      final title = args['title'] as String? ?? '';
      final body = args['body'] as String? ?? '';
      final isProximity = args['is_proximity'] as bool? ?? true;
      if (alarmId != null && !dismissScreenShowing) {
        dismissScreenShowing = true;
        _showDismissScreenFromIntent(
          alarmId: alarmId,
          isProximity: isProximity,
          title: title,
          body: body,
          onDismissed: () => dismissScreenShowing = false,
        );
      }
    }
  });

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: _AppWithServices(
        onScreenLocked: () {
          final alarm = container.read(alarmServiceProvider);
          if (alarm != null && !dismissScreenShowing) {
            dismissScreenShowing = true;
            _showDismissScreen(alarm, () {
              dismissScreenShowing = false;
            });
          }
        },
      ),
    ),
  );
}

/// Check if the app was launched via a full-screen alarm intent.
/// [acquireDismiss] is called to mark dismiss as showing; returns the
/// onDismissed callback, or null if a dismiss screen is already showing.
Future<void> _checkLaunchIntent(VoidCallback? Function() acquireDismiss) async {
  try {
    final data = await _screenChannel.invokeMethod<Map<Object?, Object?>>(
      'getLaunchAlarmData',
    );
    if (data == null) return;

    final alarmId = data['alarm_id'] as int?;
    if (alarmId == null) return;

    final onDismissed = acquireDismiss();
    if (onDismissed == null) return;

    final title = data['title'] as String? ?? '';
    final body = data['body'] as String? ?? '';
    final isProximity = data['is_proximity'] as bool? ?? true;

    // Wait for the navigator to be ready (runApp may not have completed yet)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDismissScreenFromIntent(
        alarmId: alarmId,
        isProximity: isProximity,
        title: title,
        body: body,
        onDismissed: onDismissed,
      );
    });
  } on MissingPluginException {
    // ignore
  }
}

void _showDismissScreenFromIntent({
  required int alarmId,
  required bool isProximity,
  required String title,
  required String body,
  required VoidCallback onDismissed,
}) {
  navigatorKey.currentState?.push(
    MaterialPageRoute<void>(
      builder: (_) => AlarmRingScreen(
        alarmId: alarmId,
        isProximity: isProximity,
        title: title,
        body: body,
        onDismissed: onDismissed,
      ),
    ),
  );
}

Future<void> _showDismissScreenIfNeeded(
  AlarmData alarm, {
  required bool Function() isDismissShowing,
  required void Function(bool) setDismissShowing,
}) async {
  if (isDismissShowing()) return;

  final screenOff = await _isScreenOff();
  if (screenOff) {
    setDismissShowing(true);
    _showDismissScreen(alarm, () {
      setDismissShowing(false);
    });
  }
  // Screen on: the native notification (shown by background isolate) handles
  // dismiss via AlarmDismissReceiver — no Flutter UI needed.
}

void _showDismissScreen(AlarmData alarm, VoidCallback onDismissed) {
  final (title, body) = switch (alarm) {
    ProximityAlarmData(:final radius) => (
      'Location Alarm',
      'You are within ${radius.round()} m of your destination',
    ),
    DepartureAlarmData(:final travelMode) => (
      'Time to Leave',
      'Leave now by ${travelMode.name} to arrive on time',
    ),
  };

  navigatorKey.currentState?.push(
    MaterialPageRoute<void>(
      builder: (_) => AlarmRingScreen(
        alarmId: alarm.id!,
        isProximity: alarm is ProximityAlarmData,
        title: title,
        body: body,
        onDismissed: onDismissed,
      ),
    ),
  );
}

class _AppWithServices extends ConsumerStatefulWidget {
  const _AppWithServices({required this.onScreenLocked});

  final VoidCallback onScreenLocked;

  @override
  ConsumerState<_AppWithServices> createState() => _AppWithServicesState();
}

class _AppWithServicesState extends ConsumerState<_AppWithServices>
    with WidgetsBindingObserver {
  AppLifecycleState? _previousState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_previousState == AppLifecycleState.resumed &&
        state == AppLifecycleState.paused) {
      widget.onScreenLocked();
    }
    _previousState = state;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(alarmServiceProvider);
    ref.watch(foregroundServiceProvider);
    return const LocationAlarmApp();
  }
}
