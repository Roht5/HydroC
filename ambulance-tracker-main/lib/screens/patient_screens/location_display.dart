import 'package:ambulance_tracker/screens/patient_screens/location_loader.dart';
import 'package:ambulance_tracker/screens/patient_screens/sort_hospital.dart';
import 'package:flutter/material.dart';

import '../../Components/title_description_richtext.dart';

class LocationDisplay extends StatefulWidget {
  const LocationDisplay({Key? key}) : super(key: key);

  @override
  State<LocationDisplay> createState() => _LocationDisplayState();
}

class _LocationDisplayState extends State<LocationDisplay> {
  @override
  Widget build(BuildContext context) {
    getLatLong();
    getDateTime();
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                child: const Text("Refresh location"),
                onPressed: () async {
                  // getLocation();
                  getLatLong();
                  getDateTime();
                  // getAddressAA(lat, long);
                  setState(() {});
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromRGBO(143, 148, 251, 1))),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleDescriptionRichText('Date: ', dateTimeC),
                    TitleDescriptionRichText('Address: ', address),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

var dateTimeC;
void getDateTime() {
  final now = DateTime.now();
  final berlinWallFell = DateTime.utc(1989, 11, 9);
  final moonLanding = DateTime.parse('1969-07-20 20:18:04');
  dateTimeC =
      '${now.day}/${now.month}/${now.year}  ${now.hour}:${now.minute}:${now.second}';
}
