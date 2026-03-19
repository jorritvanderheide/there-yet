import 'package:flutter/material.dart';
import 'package:location_alarm/shared/data/models/alarm.dart';
import 'package:location_alarm/shared/data/models/travel_mode.dart';

class AlarmCard extends StatefulWidget {
  const AlarmCard({
    super.key,
    required this.alarm,
    required this.onTap,
    required this.onToggle,
  });

  final AlarmData alarm;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggle;

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  late bool _active;

  @override
  void initState() {
    super.initState();
    _active = widget.alarm.active;
  }

  @override
  void didUpdateWidget(AlarmCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.alarm.active != widget.alarm.active) {
      _active = widget.alarm.active;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final (icon, subtitle) = switch (widget.alarm) {
      ProximityAlarmData(:final radius) => (
        Icons.notifications,
        '${radius.round()} m radius',
      ),
      DepartureAlarmData(
        :final travelMode,
        :final bufferMinutes,
        :final arrivalTime,
      ) =>
        (
          Icons.directions_walk,
          _departureSubtitle(travelMode, bufferMinutes, arrivalTime),
        ),
    };

    final title = widget.alarm.name.isEmpty
        ? switch (widget.alarm) {
            ProximityAlarmData() => 'Proximity alarm',
            DepartureAlarmData() => 'Departure alarm',
          }
        : widget.alarm.name;

    return Card.filled(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: Icon(
          icon,
          color: _active ? colorScheme.primary : colorScheme.onSurfaceVariant,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: _active ? null : colorScheme.onSurfaceVariant,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Switch(
          value: _active,
          onChanged: (active) {
            setState(() => _active = active);
            widget.onToggle(active);
          },
        ),
        onTap: widget.onTap,
      ),
    );
  }

  String _departureSubtitle(
    TravelMode travelMode,
    int bufferMinutes,
    DateTime arrivalTime,
  ) {
    final hour = arrivalTime.hour.toString().padLeft(2, '0');
    final minute = arrivalTime.minute.toString().padLeft(2, '0');
    return 'Arrive by $hour:$minute · ${travelMode.name} · +$bufferMinutes min';
  }
}
