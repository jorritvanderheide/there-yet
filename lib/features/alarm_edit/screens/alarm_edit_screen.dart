import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_alarm/features/alarm_edit/widgets/alarm_type_selector.dart';
import 'package:location_alarm/features/alarm_edit/widgets/departure_settings.dart';
import 'package:location_alarm/features/alarm_edit/widgets/location_preview.dart';
import 'package:location_alarm/features/alarm_edit/widgets/sound_picker.dart';
import 'package:location_alarm/features/map_picker/screens/map_picker_screen.dart';
import 'package:location_alarm/shared/data/models/alarm.dart';
import 'package:location_alarm/shared/data/models/alarm_mode.dart';
import 'package:location_alarm/shared/data/models/travel_mode.dart';
import 'package:location_alarm/shared/providers/alarm_repository_provider.dart';

class AlarmEditScreen extends ConsumerStatefulWidget {
  const AlarmEditScreen({super.key, this.alarmId});

  final int? alarmId;

  @override
  ConsumerState<AlarmEditScreen> createState() => _AlarmEditScreenState();
}

class _AlarmEditScreenState extends ConsumerState<AlarmEditScreen> {
  bool _isNew = true;
  bool _loaded = false;

  AlarmMode _mode = AlarmMode.proximity;
  late TextEditingController _labelController;
  LatLng? _location;
  double _radius = 500;
  TravelMode _travelMode = TravelMode.walk;
  int _bufferMinutes = 5;
  DateTime? _arrivalTime;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController();
    _isNew = widget.alarmId == null;
    if (!_isNew) {
      _loadAlarm();
    } else {
      _loaded = true;
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  Future<void> _loadAlarm() async {
    final repo = ref.read(alarmRepositoryProvider);
    final alarms = await repo.watchAll().first;
    final alarm = alarms.where((a) => a.id == widget.alarmId).firstOrNull;
    if (alarm == null) {
      if (mounted) context.go('/');
      return;
    }

    setState(() {
      _labelController.text = alarm.name;
      _location = alarm.location;
      switch (alarm) {
        case ProximityAlarmData(:final radius):
          _mode = AlarmMode.proximity;
          _radius = radius;
        case DepartureAlarmData(
          :final travelMode,
          :final bufferMinutes,
          :final arrivalTime,
        ):
          _mode = AlarmMode.departure;
          _travelMode = travelMode;
          _bufferMinutes = bufferMinutes;
          _arrivalTime = arrivalTime;
      }
      _loaded = true;
    });
  }

  Future<void> _save() async {
    if (_location == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please pick a location')));
      return;
    }

    final repo = ref.read(alarmRepositoryProvider);
    final alarm = switch (_mode) {
      AlarmMode.proximity => ProximityAlarmData(
        id: widget.alarmId,
        name: _labelController.text,
        location: _location!,
        active: true,
        radius: _radius,
      ),
      AlarmMode.departure => DepartureAlarmData(
        id: widget.alarmId,
        name: _labelController.text,
        location: _location!,
        active: true,
        travelMode: _travelMode,
        bufferMinutes: _bufferMinutes,
        arrivalTime: _arrivalTime ?? DateTime.now(),
      ),
    };

    await repo.save(alarm);
    if (mounted) context.go('/');
  }

  Future<void> _delete() async {
    if (widget.alarmId == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete alarm?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    await ref.read(alarmRepositoryProvider).delete(widget.alarmId!);
    if (mounted) context.go('/');
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.of(context).push<MapPickerResult>(
      MaterialPageRoute(
        builder: (_) => MapPickerScreen(
          initialLocation: _location,
          initialRadius: _mode == AlarmMode.proximity ? _radius : null,
          mode: _mode,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        _location = result.location;
        if (result.radius != null) {
          _radius = result.radius!;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'New alarm' : 'Edit alarm'),
        actions: [
          FilledButton(onPressed: _save, child: const Text('Save')),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_isNew) ...[
            AlarmTypeSelector(
              selected: _mode,
              onChanged: (mode) => setState(() => _mode = mode),
            ),
            const SizedBox(height: 24),
          ],
          TextField(
            decoration: const InputDecoration(
              labelText: 'Label',
              border: OutlineInputBorder(),
            ),
            controller: _labelController,
          ),
          const SizedBox(height: 24),
          LocationPreview(
            location: _location,
            radius: _mode == AlarmMode.proximity ? _radius : null,
            mode: _mode,
            onTap: _pickLocation,
          ),
          if (_mode == AlarmMode.proximity && _location != null) ...[
            const SizedBox(height: 8),
            Text(
              'Radius: ${_radius.round()} m',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          if (_mode == AlarmMode.departure) ...[
            const SizedBox(height: 24),
            DepartureSettings(
              travelMode: _travelMode,
              bufferMinutes: _bufferMinutes,
              arrivalTime: _arrivalTime,
              onTravelModeChanged: (m) => setState(() => _travelMode = m),
              onBufferChanged: (b) => setState(() => _bufferMinutes = b),
              onArrivalTimeChanged: (t) => setState(() => _arrivalTime = t),
            ),
          ],
          const SizedBox(height: 16),
          const SoundPicker(),
          if (!_isNew) ...[
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: _delete,
              icon: const Icon(Icons.delete_outline),
              label: const Text('Delete alarm'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
