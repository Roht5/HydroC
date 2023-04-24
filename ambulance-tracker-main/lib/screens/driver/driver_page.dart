import 'package:ambulance_tracker/services/current_location.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  _DriverPageState createState() => _DriverPageState();
}

var loc = [];
String currLoc = "";
String address = "";
bool isWorking = false;
bool isAvailable = true;

class _DriverPageState extends State<DriverPage> {
  @override
  void initState() {
    super.initState();
    currentLoc();
  }

  @override
  Widget build(BuildContext context) {
    currentLoc();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver page"),
        backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height / 8,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Image.network(
                                "https://static.wikia.nocookie.net/pokemon/images/8/88/Char-Eevee.png/revision/latest?cb=20190625223735"),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Name: Chakit Dalmia"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Available: ",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Working: ",
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.height / 2,
              child: !isWorking
                  ? patientData()
                  : Card(
                      child: Image.network(
                          "https://img.freepik.com/free-vector/lazy-raccoon-sleeping-cartoon_125446-631.jpg?size=338&ext=jpg"),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget patientData() {
    return GestureDetector(
      onTap: () async {
        currentLoc();

        //address = currLoc.split("{}")[2];
        //loc = currLoc.split("{}")[1].split(" , ");
        address = "Patient's address";
        loc = [0, 0];

        setState(() {
          loc;
          address;
        });
      },
      child: Card(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Current Patient",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Image.network(
              "https://www.zyrgon.com/wp-content/uploads/2019/06/googlemaps-Zyrgon.jpg"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(address),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Location: Manish Nagar, Andheri West, Mumbai"),
          ),
        ],
      )),
    );
  }

  void currentLoc() async {
    // currLoc = await getLoc();
  }
}
