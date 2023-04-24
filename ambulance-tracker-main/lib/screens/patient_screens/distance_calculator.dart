import 'dart:math';

double getDistanceFromLatLonInKm(
    double lat1, double lon1, double lat2, double lon2) {
  double R = 6371; // Radius of the earth in km
  double dLat = _deg2rad(lat2 - lat1); // deg2rad below
  double dLon = _deg2rad(lon2 - lon1);
  double a = pow(sin(dLat / 2), 2) +
      cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * pow(sin(dLon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double d = R * c; // Distance in km
  return d;
}

double _deg2rad(double deg) {
  return deg * (pi / 180);
}
