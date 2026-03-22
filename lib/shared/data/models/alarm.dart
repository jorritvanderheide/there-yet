import 'package:latlong2/latlong.dart';

final class AlarmData {
  const AlarmData({
    this.id,
    required this.name,
    required this.location,
    required this.active,
    this.createdAt,
    this.updatedAt,
    required this.radius,
    this.locationName = '',
  });

  final int? id;
  final String name;
  final LatLng location;
  final bool active;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double radius;
  final String locationName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmData &&
          id == other.id &&
          name == other.name &&
          location == other.location &&
          active == other.active &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          radius == other.radius &&
          locationName == other.locationName;

  @override
  int get hashCode => Object.hash(
    id,
    name,
    location,
    active,
    createdAt,
    updatedAt,
    radius,
    locationName,
  );
}
