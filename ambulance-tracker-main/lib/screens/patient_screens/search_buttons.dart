import 'package:ambulance_tracker/screens/patient_screens/sort_hospital.dart';
import 'package:flutter/material.dart';
import 'package:ambulance_tracker/services/MapUtils.dart';

class SearchButtons extends StatelessWidget {
  const SearchButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          child: ElevatedButton(
              child: const Text("See nearby hospitals"),
              onPressed: () async {
                MapUtils.openMap(latitude, longitude);
              }),
        ),
        Container(
          alignment: Alignment.center,
          child: ElevatedButton(
              child: const Text("See nearby ambulance"),
              onPressed: () async {
                MapUtils.openMap2(latitude, longitude);
              }),
        ),
      ],
    );
  }
}
