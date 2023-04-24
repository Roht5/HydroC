// import 'dart:async';

// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// import '../screens/patient_screens/sort_hospital.dart';

// late LocationData _currentPosition;
// String _address = "";
// late GoogleMapController mapController;
// late Marker marker;
// Location location=Location();
// late CameraPosition _cameraPosition =
//     const CameraPosition(target: LatLng(0, 0), zoom: 10.0);

// LatLng _initialcameraposition = const LatLng(0.5937, 0.9629);

// Future<String> getLoc() async {
//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;

//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       return "null";
//     }
//   }

//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       return "null";
//     }
//   }
//   String details = "";

//   _currentPosition = await location.getLocation();

//   DateTime now = DateTime.now();

//   details += "";
//   details += DateFormat('EEE d MMM kk:mm:ss ').format(now);

//   _initialcameraposition =
//       LatLng(_currentPosition.latitude!, _currentPosition.longitude!);

//   _getAddress(_currentPosition.latitude!, _currentPosition.longitude!)
//       .then((value) {
//     _address = value.first.addressLine;
//   });
//   details += "{}";
//   details += _currentPosition.latitude.toString() +
//       " , " +
//       _currentPosition.longitude.toString();
//   details += "{}";
//   details += _address;

//   return details;
// }

// Future<String> _getAddress(double lat, double lang) async {
//   // final coordinates = Coordinates(lat, lang);
//   // List<Address> add =
//   //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   // return add;
//   List<Placemark> placemarks =
//       await placemarkFromCoordinates(latitude, longitude);
//   Placemark place = placemarks[0];
//   String address =
//       "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
//   return address;
// }









