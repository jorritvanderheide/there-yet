import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:there_yet/l10n/app_localizations.dart';
import 'package:there_yet/shared/data/models/alarm.dart';

class OtherAlarmsLayer extends StatelessWidget {
  const OtherAlarmsLayer({super.key, required this.alarms, this.onAlarmTap});

  final List<AlarmData> alarms;
  final void Function(AlarmData alarm)? onAlarmTap;

  @override
  Widget build(BuildContext context) {
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
