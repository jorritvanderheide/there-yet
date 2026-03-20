import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_alarm/shared/data/models/travel_mode.dart';

// Average speeds in meters per minute
const travelSpeeds = {
  TravelMode.walk: 83.3, // ~5 km/h
  TravelMode.cycle: 250.0, // ~15 km/h
  TravelMode.drive: 833.3, // ~50 km/h
};

const _distanceCalc = Distance();

class DepartureInfo {
  const DepartureInfo({required this.departureTime, required this.remaining});

  final DateTime departureTime;
  final Duration remaining;

  bool get shouldLeaveNow => remaining.isNegative;
}

DepartureInfo? calculateDeparture({
  required LatLng currentPosition,
  required LatLng destination,
  required TravelMode travelMode,
  required int bufferMinutes,
  required DateTime arrivalTime,
}) {
  final distance = _distanceCalc.as(
    LengthUnit.Meter,
    currentPosition,
    destination,
  );
  final speed = travelSpeeds[travelMode] ?? travelSpeeds[TravelMode.walk]!;
  final travelMinutes = distance / speed;
  final totalMinutes = travelMinutes + bufferMinutes;
  final departureTime = arrivalTime.subtract(
    Duration(minutes: totalMinutes.ceil()),
  );
  final remaining = departureTime.difference(DateTime.now());

  return DepartureInfo(departureTime: departureTime, remaining: remaining);
}

double distanceInMeters(LatLng from, LatLng to) {
  return _distanceCalc.as(LengthUnit.Meter, from, to);
}

String formatDepartureInfo(DepartureInfo info, BuildContext context) {
  final timeStr = TimeOfDay.fromDateTime(info.departureTime).format(context);

  if (info.shouldLeaveNow) return 'Leave now!';

  if (info.remaining.inHours > 0) {
    return 'Leave at $timeStr (${info.remaining.inHours}h ${info.remaining.inMinutes % 60}min)';
  }
  return 'Leave at $timeStr (${info.remaining.inMinutes} min)';
}
