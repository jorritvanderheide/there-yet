import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_alarm/shared/providers/location_provider.dart';

class CenterOnLocationButton extends ConsumerWidget {
  const CenterOnLocationButton({super.key, required this.mapController});

  final MapController mapController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton.filledTonal(
      onPressed: () {
        final locationAsync = ref.read(locationProvider);
        locationAsync.whenData((position) {
          mapController.move(LatLng(position.latitude, position.longitude), 15);
        });
      },
      icon: const Icon(Icons.my_location),
    );
  }
}
