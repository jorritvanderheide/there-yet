import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_alarm/shared/data/models/alarm_mode.dart';
import 'package:location_alarm/shared/providers/location_provider.dart';

const _distanceCalc = Distance();

class LocationPreview extends ConsumerWidget {
  const LocationPreview({
    super.key,
    this.location,
    this.radius,
    this.mode = AlarmMode.proximity,
    required this.onTap,
  });

  final LatLng? location;
  final double? radius;
  final AlarmMode mode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final locationAsync = ref.watch(locationProvider);
    final currentPosition = locationAsync.whenData((p) => p).value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outline),
              ),
              clipBehavior: Clip.antiAlias,
              child: location != null
                  ? IgnorePointer(
                      child: FlutterMap(
                        options: _mapOptions(currentPosition),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'nl.bw20.location_alarm',
                          ),
                          if (mode == AlarmMode.proximity && radius != null)
                            CircleLayer(
                              circles: [
                                CircleMarker(
                                  point: location!,
                                  radius: radius!,
                                  useRadiusInMeter: true,
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderColor: colorScheme.primary.withValues(
                                    alpha: 0.6,
                                  ),
                                  borderStrokeWidth: 2,
                                ),
                              ],
                            ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: location!,
                                width: 32,
                                height: 32,
                                child: Icon(
                                  mode == AlarmMode.proximity
                                      ? Icons.notifications
                                      : Icons.place,
                                  size: 32,
                                  color: colorScheme.primary,
                                ),
                              ),
                              if (mode == AlarmMode.departure &&
                                  currentPosition != null)
                                Marker(
                                  point: LatLng(
                                    currentPosition.latitude,
                                    currentPosition.longitude,
                                  ),
                                  width: 16,
                                  height: 16,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.map,
                            size: 32,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap to pick location',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  MapOptions _mapOptions(Position? currentPosition) {
    if (mode == AlarmMode.proximity && radius != null) {
      // Fit the circle area with padding
      final offset = _distanceCalc.offset(location!, radius!, 0);
      final latDiff = (offset.latitude - location!.latitude).abs() * 1.5;
      return MapOptions(
        initialCenter: location!,
        initialCameraFit: CameraFit.bounds(
          bounds: LatLngBounds(
            LatLng(location!.latitude - latDiff, location!.longitude - latDiff),
            LatLng(location!.latitude + latDiff, location!.longitude + latDiff),
          ),
          padding: const EdgeInsets.all(16),
        ),
      );
    }

    if (mode == AlarmMode.departure && currentPosition != null) {
      // Fit both current position and destination
      final curLatLng = LatLng(
        currentPosition.latitude,
        currentPosition.longitude,
      );
      return MapOptions(
        initialCameraFit: CameraFit.bounds(
          bounds: LatLngBounds.fromPoints([location!, curLatLng]),
          padding: const EdgeInsets.all(32),
        ),
      );
    }

    return MapOptions(initialCenter: location!, initialZoom: 15);
  }
}
