import 'package:ambulance_tracker/screens/patient_screens/search_buttons.dart';
import 'package:flutter/material.dart';

import 'hospitals_list.dart';
import 'location_display.dart';

class PatientScreenNew extends StatefulWidget {
  const PatientScreenNew({Key? key}) : super(key: key);

  @override
  State<PatientScreenNew> createState() => _PatientScreenNewState();
}

class _PatientScreenNewState extends State<PatientScreenNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
      ),
      backgroundColor: const Color.fromRGBO(222, 224, 252, 1),
      body: Column(
        children: const [
          LocationDisplay(),
          SearchButtons(),
          Expanded(child: HospitalList())
        ],
      ),
    );
  }
}
