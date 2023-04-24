import 'package:ambulance_tracker/screens/driver/curr_patient.dart';
import 'package:ambulance_tracker/screens/driver/driver_information.dart';
import 'package:flutter/material.dart';

bool isWorking = true;

class SelectedDriverPage extends StatelessWidget {
  var id;
  SelectedDriverPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Page'),
      ),
      body: Column(
        children: [
          DriverInformation(id),
          const CurrentPatientWorking(),
        ],
      ),
    );
  }
}
