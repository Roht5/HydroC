import 'package:ambulance_tracker/Components/title_description_richtext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice_page.dart';

int iindex = -1;

class AssignAmbulance extends StatelessWidget {
  var id;
  AssignAmbulance(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    iindex = -1;
    return Container(
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Available Drivers,',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Expanded(child: DriverSort(id)),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  if (iindex == -1) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Assign One Driver")));
                  } else {
                    AssignSelectedDriver(id);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Driver Assigned")));
                  }
                },
                child: const Text(
                  'Assign Selected Driver',
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}

void AssignSelectedDriver(String id) {
  print('is here');
  final hosid = FirebaseFirestore.instance
      .collection('hospitalData')
      .doc(myUid)
      .collection('drivers')
      .doc(selectedDriver);
  FirebaseFirestore.instance
      .collection('hospitalData')
      .doc(myUid)
      .collection('patient')
      .doc(id)
      .update({'isAssigned': true});
  hosid.update({'currPatient': id, 'isFree': false, 'isAvailable': false});
}

var selectedDriver;

class DriverSort extends StatefulWidget {
  var id;
  DriverSort(this.id, {Key? key}) : super(key: key);

  @override
  State<DriverSort> createState() => _DriverSortState();
}

class _DriverSortState extends State<DriverSort> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("hospitalData")
          .doc(myUid)
          .collection('drivers')
          .where('isAvailable', isEqualTo: true)
          .where('isFree', isEqualTo: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final userSnapshot = snapshot.data?.docs;
        if (userSnapshot!.isEmpty) {
          return const Text("no data");
        }
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: userSnapshot.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(25),
                    child: GestureDetector(
                      onTap: () {
                        selectedDriver = userSnapshot[index].id;
                        setState(() {
                          if (iindex == index) {
                            iindex = -1;
                          } else {
                            iindex = index;
                          }
                        });
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: (iindex == index)
                                ? Colors.green
                                : Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleDescriptionRichText('Name of Driver: ',
                                userSnapshot[index]['name']),
                            TitleDescriptionRichText('Registration No.: ',
                                userSnapshot[index]['reg_id']),
                            TitleDescriptionRichText(
                                'Driver Status: ', 'Available'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
