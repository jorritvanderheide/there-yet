import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_alarm/shared/providers/location_permission_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Shows a rationale dialog explaining why background location is needed,
/// then requests the permission.
///
/// Returns `true` if background location was granted.
Future<bool> requestBackgroundWithRationale(
  BuildContext context,
  WidgetRef ref,
) async {
  final notifier = ref.read(locationPermissionProvider.notifier);

  // Already granted — nothing to do.
  if ((await Permission.locationAlways.status).isGranted) {
    ref.read(backgroundPermissionProvider.notifier).set(true);
    return true;
  }

  if (!context.mounted) return false;

  // Show rationale dialog.
  final proceed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Background location needed'),
      content: const Text(
        'Location Alarm needs to monitor your location in the background '
        'to trigger alarms when you arrive.\n\n'
        'On the next screen, select "Allow all the time".',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Continue'),
        ),
      ],
    ),
  );
  if (proceed != true) return false;

  return notifier.requestBackground();
}

/// Ensures foreground location permission is granted.
///
/// If not yet granted, requests it. Returns `true` if granted.
Future<bool> ensureForegroundLocation(
  BuildContext context,
  WidgetRef ref,
) async {
  if ((await Permission.locationWhenInUse.status).isGranted) return true;

  await ref.read(locationPermissionProvider.notifier).request();
  return ref.read(locationPermissionProvider) == PermissionStatus.granted;
}

/// Requests battery optimization exemption with a rationale dialog.
///
/// Returns `true` if the exemption was granted.
Future<bool> requestBatteryOptimization(
  BuildContext context,
  WidgetRef ref,
) async {
  if (await Permission.ignoreBatteryOptimizations.isGranted) {
    ref.read(batteryOptimizationProvider.notifier).set(true);
    return true;
  }

  if (!context.mounted) return false;

  final proceed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Disable battery optimization'),
      content: const Text(
        'To reliably monitor your location in the background, '
        'Location Alarm needs to be excluded from battery optimization.\n\n'
        'Without this, Android may stop the alarm service to save battery.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Skip'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Disable optimization'),
        ),
      ],
    ),
  );
  if (proceed != true) return false;

  return ref
      .read(locationPermissionProvider.notifier)
      .requestBatteryOptimization();
}
