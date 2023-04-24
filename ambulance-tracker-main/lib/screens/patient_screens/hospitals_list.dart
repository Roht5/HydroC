import 'package:ambulance_tracker/Components/title_description_richtext.dart';
import 'package:ambulance_tracker/screens/patient_screens/request_hospital.dart';
import 'package:ambulance_tracker/screens/patient_screens/sort_hospital.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HospitalList extends StatelessWidget {
  const HospitalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("hospitalData").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final userSnapshot = snapshot.data?.docs;
        if (userSnapshot!.isEmpty) {
          return const Text("no data");
        }
        addHospitals(userSnapshot);

        return SortedHospitalListDisplayWidget();
      },
    );
  }
}

class SortedHospitalListDisplayWidget extends StatefulWidget {
  const SortedHospitalListDisplayWidget({Key? key}) : super(key: key);

  @override
  State<SortedHospitalListDisplayWidget> createState() =>
      _SortedHospitalListDisplayWidgetState();
}

class _SortedHospitalListDisplayWidgetState
    extends State<SortedHospitalListDisplayWidget> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 3),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: _calculation, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: sortingHospital.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HospitalDisplayFormat(index);
                    }),
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

class HospitalDisplayFormat extends StatelessWidget {
  int index;
  HospitalDisplayFormat(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAddress();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: const Color.fromRGBO(143, 148, 251, 1)),
                borderRadius: BorderRadius.circular(15)),
            width: MediaQuery.of(context).size.width - 50,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TitleDescriptionRichText(
                    'Hospital Name: ', sortingHospital[index]['name']),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TitleDescriptionRichText(
                    'Location: ', sortingHospital[index]['location']),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      child: const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        requestHospital(sortingHospital[index]['id']);
                        Fluttertoast.showToast(
                            msg:
                                "Hospital chosen, you'll be notified about the ambulance",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      }),
                  ElevatedButton(
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Hospital rejected",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      }),
                  const Icon(Icons.location_on)
                ],
              )
            ])),
      ),
    );
  }
}
