import 'package:ambulance_tracker/Components/title_description_richtext.dart';
import 'package:ambulance_tracker/screens/choice_page.dart';
import 'package:ambulance_tracker/screens/driver/selected_driver_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var selectedDriver;
var iindex = -1;

class DriverSelectScreen extends StatelessWidget {
  const DriverSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    iindex = -1;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Driver,',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Expanded(child: DriverSelect()),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      if (iindex == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Select One Driver")));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SelectedDriverPage(selectedDriver),
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Driver Selected")));
                      }
                    },
                    child: const Text(
                      'Assign Selected Driver',
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DriverSelect extends StatefulWidget {
  const DriverSelect({Key? key}) : super(key: key);

  @override
  State<DriverSelect> createState() => _DriverSelectState();
}

class _DriverSelectState extends State<DriverSelect> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("hospitalData")
          .doc(myUid)
          .collection('drivers')
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
