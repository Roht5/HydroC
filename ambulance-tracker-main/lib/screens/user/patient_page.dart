import 'package:ambulance_tracker/services/MapUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

import '../../Components/title_description_richtext.dart';

var currLatitude;
var currLongitude;
Future<void> _getCurrentLocation() async {
  final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print('latitude' + position.latitude.toString());
  print(position.longitude);
}

class PatientPage extends StatefulWidget {
  const PatientPage({Key? key}) : super(key: key);

  @override
  _PatientPageState createState() => _PatientPageState();
}

String currLoc = "";
var details = [];
String date_time = "", address = "";
var loc = [];

void currentLoc() async {
  // currLoc = await getLoc();
  print('currLoc : ' + currLoc);
  date_time = currLoc.split("{}")[0];
  address = currLoc.split("{}")[2];
  loc = currLoc.split("{}")[1].split(" , ");
}

class _PatientPageState extends State<PatientPage> {
  @override
  void initState() {
    super.initState();
    currentLoc();
  }

  @override
  Widget build(BuildContext context) {
    currentLoc();

    try {
      loc[0];
    } catch (e) {
      currentLoc();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
        ),
        backgroundColor: const Color.fromRGBO(222, 224, 252, 1),
        body: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    child: const Text("Refresh location"),
                    onPressed: () async {
                      currentLoc();

                      date_time = currLoc.split("{}")[0];
                      address = currLoc.split("{}")[2];
                      loc = currLoc.split("{}")[1].split(" , ");

                      setState(() {
                        currLoc;
                        date_time;
                        address;
                        loc;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: const Color.fromRGBO(143, 148, 251, 1))),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleDescriptionRichText('Date: ', date_time),
                        TitleDescriptionRichText('Address: ', address),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        child: const Text("See nearby hospitals"),
                        onPressed: () async {
                          MapUtils.openMap(
                              double.parse(loc[0]), double.parse(loc[1]));
                        }),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        child: const Text("See nearby ambulance"),
                        onPressed: () async {
                          MapUtils.openMap2(
                              double.parse(loc[0]), double.parse(loc[1]));
                        }),
                  ),
                ],
              ),
              const Expanded(child: HospitalsList())
            ]));
  }
}

double getDistanceFromLatLonInKm(
    double lat1, double lon1, double lat2, double lon2) {
  double R = 6371; // Radius of the earth in km
  double dLat = _deg2rad(lat2 - lat1); // deg2rad below
  double dLon = _deg2rad(lon2 - lon1);
  double a = pow(sin(dLat / 2), 2) +
      cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * pow(sin(dLon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double d = R * c; // Distance in km
  return d;
}

double _deg2rad(double deg) {
  return deg * (pi / 180);
}

class HospitalsList extends StatefulWidget {
  const HospitalsList({Key? key}) : super(key: key);

  @override
  State<HospitalsList> createState() => _HospitalsListState();
}

class HospitalList extends StatelessWidget {
  const HospitalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("hospitalData")
          // .orderBy('latitude')
          .orderBy('longitude')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final userSnapshot = snapshot.data?.docs;
        if (userSnapshot!.isEmpty) {
          return const Text("no data");
        }
        return ListView.builder(
            itemCount: userSnapshot.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromRGBO(143, 148, 251, 1)),
                          borderRadius: BorderRadius.circular(15)),
                      width: MediaQuery.of(context).size.width - 50,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TitleDescriptionRichText('Hospital Name: ',
                                  userSnapshot[index]['name']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TitleDescriptionRichText('Location: ',
                                  userSnapshot[index]['location']),
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
            });
      },
    );
  }
}

class _HospitalsListState extends State<HospitalsList> {
  @override
  Widget build(BuildContext context) {
    return const HospitalList();
    // return ListView(
    //   children: getHosps(),
    // );
  }

  List<Widget> getHosps() {
    List<Widget> lst = [];
    for (int i = 1; i <= 4; i++) {
      lst.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height / 7,
              child: Card(
                child: Column(children: [
                  Text(
                    "Hospital " + i.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Text("Hospital Location"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            Fluttertoast.showToast(
                                msg:
                                    "Hospital chosen, you'll be notified about the ambulance",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                textColor: Colors.white,
                                fontSize: 14.0);
                          }),
                      IconButton(
                          icon: const Icon(Icons.close),
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
                ]),
              )),
        ),
      );
    }

    return lst;
  }
}

void createUser() async {
  final docUser = FirebaseFirestore.instance
      .collection('hospitalData')
      .doc('D9onYqi2ywV9uAWMzuPs5UNFego2');

  await docUser.set({
    'name': 'Bombay Hospital Institute of Medical Sciences',
    'location': 'New Marine Lines , Mumbai 400 020 , India.',
    'latitude': 19.0297161,
    'longitude': 73.0587553
  });
}
