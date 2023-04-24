import 'package:ambulance_tracker/screens/patient_screens/sort_hospital.dart';
import 'package:ambulance_tracker/services/firebase/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var UserId;
void requestHospital(String id) {
  print('is here my boy');
  var name;
  User? user = Auth().currentUser;
  String patientid = user!.uid;
  final patient =
      FirebaseFirestore.instance.collection('userData').doc(patientid);

  patient.get().then((DocumentSnapshot documentSnapshot) {
    UserId = patientid;
    if (documentSnapshot.exists) {
      name = documentSnapshot.get('name');
      final hospital = FirebaseFirestore.instance
          .collection('hospitalData')
          .doc(id)
          .collection('patient')
          .doc();
      hospital.set({
        'name': name,
        'location': GeoPoint(latitude, longitude),
        'address': addressC,
        'isAssigned': false
      });
    } else {}
  });
}
