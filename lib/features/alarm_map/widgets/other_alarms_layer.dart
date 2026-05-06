import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:there_yet/l10n/app_localizations.dart';
import 'package:there_yet/shared/data/models/alarm.dart';
import 'package:there_yet/shared/providers/alarms_provider.dart';

/// Renders pins and radii for stored alarms, optionally omitting one.
class OtherAlarmsLayer extends ConsumerWidget {
  const OtherAlarmsLayer({super.key, this.excludeAlarmId, this.onAlarmTap});

  /// When set, the alarm with this id is omitted. Used by the edit screen so
  /// the alarm being edited isn't drawn twice.
  final int? excludeAlarmId;
  final void Function(AlarmData alarm)? onAlarmTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAlarms = ref.watch(alarmsProvider);
    if (kDebugMode && asyncAlarms.hasError) {
      debugPrint(
        'alarmsProvider error: ${asyncAlarms.error}\n'
        '${asyncAlarms.stackTrace}',
      );
    }
    final alarms = asyncAlarms.maybeWhen(
      data: (list) => list.where((a) => a.id != excludeAlarmId).toList(),
      orElse: () => const <AlarmData>[],
    );
    if (alarms.isEmpty) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark
        ? colorScheme.tertiaryContainer
        : colorScheme.tertiary;
    final markerColor = baseColor.withValues(alpha: 0.8);
    final radiusColor = markerColor;
    final iconColor =
        (isDark ? colorScheme.onTertiaryContainer : colorScheme.onTertiary)
            .withValues(alpha: 0.8);

    return Stack(
      children: [
        CircleLayer(
          circles: [
            for (final alarm in alarms)
              CircleMarker(
                point: alarm.location,
                radius: alarm.radius,
                useRadiusInMeter: true,
                color: radiusColor.withValues(alpha: 0.20),
                borderColor: radiusColor,
                borderStrokeWidth: 1.5,
              ),
          ],
        ),
        MarkerLayer(
          rotate: true,
          markers: [
            for (final alarm in alarms)
              Marker(
                point: alarm.location,
                width: 26,
                height: 26,
                child: Semantics(
                  label: alarm.name.isEmpty
                      ? l10n.alarmDefaultName(alarm.id ?? 0)
                      : alarm.name,
                  button: onAlarmTap != null,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onAlarmTap == null ? null : () => onAlarmTap!(alarm),
                    child: Container(
                      decoration: BoxDecoration(
                        color: markerColor,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 3),
                        ],
                      ),
                      child: Icon(
                        Icons.notifications,
                        size: 14,
                        color: iconColor,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
