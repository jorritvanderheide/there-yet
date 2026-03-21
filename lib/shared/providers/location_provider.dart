import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_alarm/shared/providers/location_permission_provider.dart';
import 'package:location_alarm/shared/providers/location_settings_provider.dart';
import 'package:permission_handler/permission_handler.dart';

final locationProvider = StreamProvider<Position>((ref) {
  final permission = ref.watch(locationPermissionProvider);
  if (permission != PermissionStatus.granted) {
    return const Stream.empty();
  }
  final usePlayServices = ref.watch(usePlayServicesProvider);
  return Geolocator.getPositionStream(
    locationSettings: AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
      forceLocationManager: !usePlayServices,
    ),
  );
});
