import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AlarmMapLayers extends StatelessWidget {
  const AlarmMapLayers({
    super.key,
    required this.location,
    required this.radius,
  });

  final LatLng location;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark
        ? colorScheme.primaryContainer
        : colorScheme.primary;

    return Stack(
      children: [
        CircleLayer(
          circles: [
            CircleMarker(
              point: location,
              radius: radius,
              useRadiusInMeter: true,
              color: accentColor.withValues(alpha: 0.25),
              borderColor: accentColor,
              borderStrokeWidth: 2,
            ),
          ],
        ),
        MarkerLayer(
          rotate: true,
          markers: [
            Marker(
              point: location,
              width: 32,
              height: 32,
              child: Container(
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 4),
                  ],
                ),
                child: Icon(
                  Icons.notifications,
                  size: 18,
                  color: isDark
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
