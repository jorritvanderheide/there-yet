import 'package:flutter/material.dart';
import 'package:location_alarm/shared/data/models/travel_mode.dart';

class DepartureSettings extends StatelessWidget {
  const DepartureSettings({
    super.key,
    required this.travelMode,
    required this.bufferMinutes,
    required this.arrivalTime,
    required this.onTravelModeChanged,
    required this.onBufferChanged,
    required this.onArrivalTimeChanged,
  });

  final TravelMode travelMode;
  final int bufferMinutes;
  final DateTime? arrivalTime;
  final ValueChanged<TravelMode> onTravelModeChanged;
  final ValueChanged<int> onBufferChanged;
  final ValueChanged<DateTime> onArrivalTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          readOnly: true,
          controller: TextEditingController(
            text: arrivalTime != null ? _formatDateTime(arrivalTime!) : '',
          ),
          decoration: const InputDecoration(
            labelText: 'Arrive by',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.schedule),
          ),
          onTap: () => _pickDateTime(context),
        ),
        const SizedBox(height: 24),
        Text('Travel mode', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        SegmentedButton<TravelMode>(
          segments: const [
            ButtonSegment(
              value: TravelMode.walk,
              label: Text('Walk'),
              icon: Icon(Icons.directions_walk),
            ),
            ButtonSegment(
              value: TravelMode.cycle,
              label: Text('Cycle'),
              icon: Icon(Icons.directions_bike),
            ),
            ButtonSegment(
              value: TravelMode.drive,
              label: Text('Drive'),
              icon: Icon(Icons.directions_car),
            ),
          ],
          selected: {travelMode},
          onSelectionChanged: (s) => onTravelModeChanged(s.first),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Text('Buffer', style: Theme.of(context).textTheme.titleSmall),
            Expanded(
              child: Slider(
                value: bufferMinutes.toDouble(),
                min: 0,
                max: 60,
                divisions: 12,
                label: '$bufferMinutes min',
                onChanged: (v) => onBufferChanged(v.round()),
              ),
            ),
            SizedBox(
              width: 56,
              child: Text(
                '$bufferMinutes min',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: arrivalTime ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: arrivalTime != null
          ? TimeOfDay.fromDateTime(arrivalTime!)
          : TimeOfDay.fromDateTime(now.add(const Duration(hours: 1))),
    );
    if (time == null) return;
    onArrivalTimeChanged(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
  }

  String _formatDateTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    final today = DateTime.now();
    if (dt.year == today.year &&
        dt.month == today.month &&
        dt.day == today.day) {
      return 'Today $hour:$minute';
    }
    final tomorrow = today.add(const Duration(days: 1));
    if (dt.year == tomorrow.year &&
        dt.month == tomorrow.month &&
        dt.day == tomorrow.day) {
      return 'Tomorrow $hour:$minute';
    }
    return '${dt.day}/${dt.month} $hour:$minute';
  }
}
