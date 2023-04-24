import 'package:ambulance_tracker/Components/title_description_richtext.dart';
import 'package:ambulance_tracker/screens/hospital/assign_ambulance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice_page.dart';

class PatientRequest extends StatelessWidget {
  const PatientRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("hospitalData")
          .doc(myUid)
          .collection('patient')
          .where('isAssigned', isEqualTo: false)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final userSnapshot = snapshot.data?.docs;
        if (userSnapshot!.isEmpty) {
          return const Center(child: Text("no Patient"));
        }
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: userSnapshot.length,
              itemBuilder: (BuildContext context, int index) {
                return PatientRequestFormat(
                    userSnapshot[index].id,
                    userSnapshot[index]['name'],
                    userSnapshot[index]['address']);
              }),
        );
      },
    );
  }
}

class PatientRequestFormat extends StatelessWidget {
  var id;
  var name;
  var address;
  PatientRequestFormat(this.id, this.name, this.address, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TitleDescriptionRichText('Name: ', name),
            TitleDescriptionRichText('Address: ', address),
            Container(
                alignment: Alignment.centerRight, child: AssignDriver(id)),
          ],
        ),
      ),
    );
  }
}

class AssignDriver extends StatefulWidget {
  var id;
  AssignDriver(this.id, {Key? key}) : super(key: key);

  @override
  State<AssignDriver> createState() => _AssignDriverState();
}

class _AssignDriverState extends State<AssignDriver> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              ModalBottomSheetRoute(
                  builder: (context) => AssignAmbulance(widget.id),
                  isScrollControlled: true));
        },
        child: const Text('Assign Ambulance'),
        style: ElevatedButton.styleFrom());
  }
}
