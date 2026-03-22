import 'package:latlong2/latlong.dart';

const _distanceCalc = Distance();

double distanceInMeters(LatLng from, LatLng to) {
  return _distanceCalc.as(LengthUnit.Meter, from, to);
}

String formatDistance(double meters) {
  if (meters >= 1000) {
    final km = meters / 1000;
    return km == km.roundToDouble()
        ? '${km.toInt()} km'
        : '${km.toStringAsFixed(1)} km';
  }
  return '${meters.round()} m';
}
