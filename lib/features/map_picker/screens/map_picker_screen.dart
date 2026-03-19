import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_alarm/features/map/widgets/alarm_map.dart';
import 'package:location_alarm/features/map/widgets/center_on_location_fab.dart';
import 'package:location_alarm/features/map/widgets/compass_button.dart';
import 'package:location_alarm/features/map/widgets/current_location_marker.dart';
import 'package:location_alarm/shared/data/models/alarm_mode.dart';
import 'package:location_alarm/shared/providers/location_permission_provider.dart';
import 'package:location_alarm/shared/providers/location_provider.dart';

class MapPickerResult {
  const MapPickerResult({required this.location, this.radius});
  final LatLng location;
  final double? radius;
}

class MapPickerScreen extends ConsumerStatefulWidget {
  const MapPickerScreen({
    super.key,
    this.initialLocation,
    this.initialRadius,
    this.mode = AlarmMode.proximity,
  });

  final LatLng? initialLocation;
  final double? initialRadius;
  final AlarmMode mode;

  @override
  ConsumerState<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends ConsumerState<MapPickerScreen> {
  final _mapController = MapController();
  LatLng? _selectedLocation;
  double _radius = 500;
  bool _hasCenteredOnLocation = false;

  bool get _isProximity => widget.mode == AlarmMode.proximity;

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initialLocation;
    _radius = widget.initialRadius ?? 500;
    if (_selectedLocation != null) {
      _hasCenteredOnLocation = true;
    }
    Future.microtask(() {
      ref.read(locationPermissionProvider.notifier).request();
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _centerOnFirstLocation() {
    if (_hasCenteredOnLocation) return;
    final locationAsync = ref.read(locationProvider);
    locationAsync.whenData((position) {
      _hasCenteredOnLocation = true;
      _mapController.move(LatLng(position.latitude, position.longitude), 15);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(locationProvider, (_, next) {
      next.whenData((_) => _centerOnFirstLocation());
    });

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pick location')),
      body: Stack(
        children: [
          AlarmMap(
            mapController: _mapController,
            onTap: (_, latLng) {
              setState(() => _selectedLocation = latLng);
            },
            children: [
              const CurrentLocationMarker(),
              if (_selectedLocation != null && _isProximity)
                CircleLayer(
                  circles: [
                    CircleMarker(
                      point: _selectedLocation!,
                      radius: _radius,
                      useRadiusInMeter: true,
                      color: colorScheme.primary.withValues(alpha: 0.15),
                      borderColor: colorScheme.primary.withValues(alpha: 0.6),
                      borderStrokeWidth: 2,
                    ),
                  ],
                ),
              if (_selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _selectedLocation!,
                      width: 48,
                      height: 48,
                      alignment: Alignment.topCenter,
                      child: Icon(
                        _isProximity ? Icons.notifications : Icons.place,
                        size: _isProximity ? 32 : 48,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if (_isProximity && _selectedLocation != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 88,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${_radius.round()} m',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Expanded(
                        child: Slider(
                          value: _radius,
                          min: 100,
                          max: 5000,
                          divisions: 49,
                          onChanged: (v) => setState(() => _radius = v),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            right: 16,
            top: 16,
            child: Column(
              children: [
                CompassButton(mapController: _mapController),
                const SizedBox(height: 8),
                CenterOnLocationButton(mapController: _mapController),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _selectedLocation != null
          ? FloatingActionButton.extended(
              heroTag: 'confirm_location',
              onPressed: () {
                Navigator.of(context).pop(
                  MapPickerResult(
                    location: _selectedLocation!,
                    radius: _isProximity ? _radius : null,
                  ),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('Confirm'),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
