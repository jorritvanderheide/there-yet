import 'package:flutter/material.dart';
import 'package:location_alarm/shared/data/models/alarm_mode.dart';

class AlarmTypeSelector extends StatelessWidget {
  const AlarmTypeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final AlarmMode selected;
  final ValueChanged<AlarmMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<AlarmMode>(
      segments: const [
        ButtonSegment(
          value: AlarmMode.proximity,
          label: Text('Proximity'),
          icon: Icon(Icons.notifications),
        ),
        ButtonSegment(
          value: AlarmMode.departure,
          label: Text('Departure'),
          icon: Icon(Icons.directions_walk),
        ),
      ],
      selected: {selected},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
