import 'package:ambulance_tracker/screens/hospital/driver_status.dart';
import 'package:ambulance_tracker/screens/hospital/hospital_appbar.dart';
import 'package:ambulance_tracker/screens/hospital/patient_requests.dart';
import 'package:flutter/material.dart';

class HospitalDashboard extends StatelessWidget {
  const HospitalDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(143, 148, 251, 0.75),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HospitalAppbar(),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: PatientRequest(),
            ),
            Spacer(),
            DriverStatus()
          ],
        ),
      ),
    );
  }
}
