import 'package:ambulance_tracker/Components/title_description_richtext.dart';
import 'package:ambulance_tracker/screens/driver/driver_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice_page.dart';

var patientid;
var patientName;
var patientAddress;

class DriverInformation extends StatefulWidget {
  var id;
  DriverInformation(this.id, {Key? key}) : super(key: key);

  @override
  State<DriverInformation> createState() => _DriverInformationState();
}

class _DriverInformationState extends State<DriverInformation> {
  var name;
  var reg_id;
  bool isAvailable = false;
  bool isFree = false;
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    final driverI = FirebaseFirestore.instance
        .collection('hospitalData')
        .doc(myUid)
        .collection('drivers')
        .doc(widget.id);

    driverI.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        name = documentSnapshot.get('name');
        reg_id = documentSnapshot.get('reg_id');
        isAvailable = documentSnapshot.get('isAvailable');
        isFree = documentSnapshot.get('isFree');
        if (!isAvailable && !isFree) {
          patientid = documentSnapshot.get('currPatient');
          print(patientid);
          isWorking = true;
          final patientI = FirebaseFirestore.instance
              .collection('hospitalData')
              .doc(myUid)
              .collection('patient')
              .doc(patientid);
          patientI.get().then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              patientName = documentSnapshot.get('name');
              patientAddress = documentSnapshot.get('address');
            } else {}
          });
        } else {
          isWorking = false;
        }
      } else {}
    });
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: _calculation, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 211, 209, 209),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Image.network(
                                  "https://static.wikia.nocookie.net/pokemon/images/8/88/Char-Eevee.png/revision/latest?cb=20190625223735"),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleDescriptionRichText('  Name : ', name),
                                TitleDescriptionRichText(
                                    '  Register No. : ', reg_id),
                              ],
                            ),
                          ],
                        ),
                        TitleDescriptionRichText(
                            "            Availability : ",
                            (isAvailable && isFree)
                                ? 'Available'
                                : (isFree)
                                    ? 'Offline '
                                    : 'Working')
                      ],
                    ),
                  ),
                ),
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
