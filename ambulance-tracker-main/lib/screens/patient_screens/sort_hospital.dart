import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'distance_calculator.dart';

var latitude;
var longitude;
var addressC;

double? lat;

double? long;

String address = "";
void getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);
  // print(position.latitude);
  // print(position.longitude);
  latitude = position.latitude;
  longitude = position.longitude;
}

List sortingHospital = [];
void addHospitals(List userSnapshot) {
  getLocation();
  // print(latitude.toString() + '   ' + longitude.toString());
  Timer(const Duration(seconds: 1), () {
    sortingHospital.clear();
    for (var i = 0; i < userSnapshot.length; i++) {
      sortingHospital.add({
        'id': userSnapshot[i].id,
        'name': userSnapshot[i]['name'],
        'address': userSnapshot[i]['location'],
        'latitude': userSnapshot[i]['latitude'],
        'longitude': userSnapshot[i]['longitude'],
        'distance': getDistanceFromLatLonInKm(userSnapshot[i]['latitude'],
            userSnapshot[i]['longitude'], latitude, longitude)
      });
    }
    sortingHospital.sort((a, b) => a['distance'].compareTo(b['distance']));
  });
}

void getAddress() async {
  getLocation();
  List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
  Placemark place = placemarks[0];
  String address =
      "${place.street},${place.name},${place.subLocality}, ${place.locality}, ${place.postalCode},${place.administrativeArea}, ${place.country}";
  addressC = address;
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}
