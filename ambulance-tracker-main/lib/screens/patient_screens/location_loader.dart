import 'package:ambulance_tracker/screens/patient_screens/sort_hospital.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

getLatLong() {
  Future<Position> data = determinePosition();
  data.then((value) {
    // print("value $value");
    lat = value.latitude;
    long = value.longitude;

    getAddressAA(value.latitude, value.longitude);
  }).catchError((error) {
    print("Error $error");
  });
}

getAddressAA(lat, long) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
  address = placemarks[0].street! + " " + placemarks[0].country!;
}
