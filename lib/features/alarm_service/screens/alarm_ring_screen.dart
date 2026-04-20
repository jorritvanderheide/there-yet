import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:there_yet/features/alarm_service/providers/alarm_service_provider.dart';
import 'package:there_yet/l10n/app_localizations.dart';
import 'package:there_yet/shared/providers/alarms_provider.dart';

class AlarmRingScreen extends ConsumerStatefulWidget {
  const AlarmRingScreen({
    super.key,
    required this.alarmId,
    required this.title,
    required this.body,
    this.onDismissed,
    this.launchedByIntent = false,
  });

  final int alarmId;
  final String title;
  final String body;
  final VoidCallback? onDismissed;

  /// `true` when the app was cold-launched by the alarm's full-screen intent.
  /// On exit we fully finish the activity so the app isn't left in recents.
  /// When `false` the app was already running; we just clear lock-screen flags
  /// and pop so the existing task state is preserved.
  final bool launchedByIntent;

  @override
  ConsumerState<AlarmRingScreen> createState() => _AlarmRingScreenState();
}

class _AlarmRingScreenState extends ConsumerState<AlarmRingScreen> {
  static const _channel = MethodChannel('nl.bw20.there_yet/screen');
  bool _dismissed = false;

  @override
  void initState() {
    super.initState();
    _showOverLockScreen();
  }

  @override
  void dispose() {
    widget.onDismissed?.call();
    super.dispose();
  }

  Future<void> _showOverLockScreen() async {
    try {
      await _channel.invokeMethod('showOverLockScreen');
    } on MissingPluginException {
      // ignore
    }
  }

  Future<void> _clearLockScreenFlags() async {
    try {
      await _channel.invokeMethod('clearLockScreenFlags');
    } on MissingPluginException {
      // ignore
    }
  }

  Future<void> _dismiss() async {
    if (_dismissed) return;
    _dismissed = true;

    await ref.read(alarmServiceProvider.notifier).dismiss(widget.alarmId);
    await _clearLockScreenFlags();
    await _exitActivity();
  }

  // Cold-launched: finish the task so the app isn't left sitting in recents.
  // Warm: pop the ring screen and launch the home activity so unlocking does
  // not force-foreground There Yet. moveTaskToBack is a no-op here because
  // the activity is still in the keyguard-occluding state, so we explicitly
  // bring the launcher to the front instead — the task is preserved for
  // later resumption via the app icon or recents.
  Future<void> _exitActivity() async {
    if (widget.launchedByIntent) {
      try {
        await _channel.invokeMethod('finishAndRemoveTask');
        return;
      } on MissingPluginException {
        // fall through to pop
      }
    }
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    if (!widget.launchedByIntent) {
      try {
        await _channel.invokeMethod('goHome');
      } on MissingPluginException {
        // ignore
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Auto-close if alarm is deactivated externally
    ref.listen(alarmsProvider, (_, next) {
      next.whenData((alarms) {
        final alarm = alarms.where((a) => a.id == widget.alarmId).firstOrNull;
        if ((alarm == null || !alarm.active) && !_dismissed) {
          _dismissed = true;
          _clearLockScreenFlags();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _exitActivity();
          });
        }
      });
    });

    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop || _dismissed) return;
        _dismissed = true;
        // Back gesture: leave the alarm ringing but exit the activity so the
        // app returns to the locked state. The user can dismiss from the
        // notification or unlock and dismiss in-app.
        await _clearLockScreenFlags();
        await _exitActivity();
      },
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications, size: 96, color: colorScheme.primary),
                const SizedBox(height: 32),
                Semantics(
                  liveRegion: true,
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Text(
                    widget.body,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 64),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: FilledButton.icon(
                    autofocus: true,
                    onPressed: _dismiss,
                    icon: const Icon(Icons.alarm_off, size: 28),
                    label: Text(l10n.dismiss),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(72),
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
