import 'package:ambulance_tracker/services/drivers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void addDrivers() {
  addDriver('6rUfIxDvOFOkmKeAx84peE5rdqi1');
}

void addDriver(String id) {
  print('is also here');
  for (var i = 0; i < drivers.length; i++) {
    print(i);
    final docUser = FirebaseFirestore.instance
        .collection('hospitalData')
        .doc(id)
        .collection('drivers')
        .doc();
    docUser.set({
      'id': drivers[i]['id'],
      'name': drivers[i]['name'],
      'isFree': drivers[i]['isFree'],
      'isAvailable': drivers[i]['isAvailable'],
      'reg_id': drivers[i]['reg_id'],
      'currPatient': ''
    });
  }
}
