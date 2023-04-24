import 'package:ambulance_tracker/Components/title_description_richtext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice_page.dart';
import 'new_driver_page.dart';
import 'package:ambulance_tracker/services/drivers.dart';

class ShowDrivers extends StatefulWidget {
  const ShowDrivers({Key? key}) : super(key: key);

  @override
  _ShowDriversState createState() => _ShowDriversState();
}

class _ShowDriversState extends State<ShowDrivers> {
  @override
  Widget build(BuildContext context) {
    List<List<Widget>> tabCats = sortDrivers();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All drivers"),
          backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.location_on),
            ),
            Tab(
              text: "Available",
            ),
            Tab(text: "Working"),
            Tab(text: "Offline"),
          ]),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.person_add_alt_1,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewDriversCode()),
                    )),
          ],
        ),
        body: TabBarView(children: [
          Column(),
          DriverSort(true, true),
          DriverSort(false, false),
          DriverSort(false, true),
          // SingleChildScrollView(
          //   child: Column(
          //     children: tabCats[1],
          //   ),
          // ),
        ]),
      ),
    );
  }

  Widget driverCard(String name, Color col, String status, String regId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          height: MediaQuery.of(context).size.height / 6,
          child: Card(
            child: Column(children: [
              Row(
                children: const [
                  // Image.network(
                  //  "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png")
                ],
              ),
              Text(name),
              Text(regId),
              Text(status)
            ]),
            color: col,
          )),
    );
  }

  List<List<Widget>> sortDrivers() {
    List<List<Widget>> lst = [];

    List<Widget> available = [];
    List<Widget> offline = [];
    List<Widget> working = [];

    for (var e in drivers) {
      if (e['isFree'] && !e['isAvailable']) {
        offline.add(driverCard(e['name'],
            const Color.fromRGBO(235, 233, 228, 1), "Offline", e["reg_id"]));
      } else if (e['isFree']) {
        available.add(driverCard(e['name'],
            const Color.fromRGBO(217, 250, 195, 1), "Available", e["reg_id"]));
      } else if (!e['isFree'] || !e['isAvailable']) {
        working.add(driverCard(e['name'],
            const Color.fromRGBO(250, 152, 152, 1), "Busy", e["reg_id"]));
      }
      lst.add(available);
      lst.add(offline);
      lst.add(working);
    }

    return lst;
  }
}

class DriverSort extends StatelessWidget {
  var isAvailable;
  var isFree;
  DriverSort(this.isAvailable, this.isFree, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("hospitalData")
          .doc(myUid)
          .collection('drivers')
          // .where('isAvailable', isEqualTo: isAvailable)
          // .where('isFree', isEqualTo: isFree)
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
                if (userSnapshot[index]['isAvailable'] == isAvailable &&
                    isFree == userSnapshot[index]['isFree']) {
                  return DriverDisplayCard(
                      userSnapshot[index]['name'],
                      userSnapshot[index]['reg_id'],
                      userSnapshot[index]['isAvailable'],
                      userSnapshot[index]['isFree']);
                } else {
                  return const SizedBox();
                }
              }),
        );
      },
    );
  }
}

class DriverDisplayCard extends StatelessWidget {
  var name;
  var reg_id;
  var isAvailable;
  var isFree;
  DriverDisplayCard(this.name, this.reg_id, this.isAvailable, this.isFree,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: (isAvailable && isFree)
                  ? const Color.fromARGB(255, 156, 233, 159)
                  : (isFree)
                      ? const Color.fromARGB(255, 199, 197, 197)
                      : const Color.fromARGB(255, 245, 179, 179)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleDescriptionRichText('Name of Driver: ', name),
              TitleDescriptionRichText('Registration No.: ', reg_id),
              TitleDescriptionRichText(
                  'Driver Status: ',
                  (isAvailable && isFree)
                      ? 'Available'
                      : (isFree)
                          ? 'Offline '
                          : 'Working'),
            ],
          ),
        ),
      ),
    );
  }
}
