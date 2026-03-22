import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_alarm/shared/providers/location_permission_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Last known position — available immediately on app start without
/// active permission. Returns null if no cached position exists.
final lastKnownPositionProvider = FutureProvider<Position?>((ref) {
  return Geolocator.getLastKnownPosition();
});

final locationProvider = StreamProvider<Position>((ref) {
  final permission = ref.watch(locationPermissionProvider);
  if (permission != PermissionStatus.granted) {
    return Stream.error(
      const PermissionDeniedException('Location permission not granted'),
    );
  }
  return Geolocator.getPositionStream(
    locationSettings: AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
      forceLocationManager: true,
    ),
  );
});
