import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'all_drivers.dart';

class DriverStatus extends StatelessWidget {
  const DriverStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -1),
                blurRadius: 1.0,
                color: Color.fromARGB(255, 136, 135, 135))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShowDrivers(),
                ));
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 235, 235),
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                FaIcon(
                  FontAwesomeIcons.addressCard,
                  color: Colors.blue,
                  size: 50,
                ),
                Text(
                  'Driver Status',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Divider(),
                Text(
                  "Total: 11",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
