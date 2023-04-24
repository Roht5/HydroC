import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HospitalAppbar extends StatefulWidget {
  const HospitalAppbar({Key? key}) : super(key: key);

  @override
  State<HospitalAppbar> createState() => _HospitalAppbarState();
}

class _HospitalAppbarState extends State<HospitalAppbar> {
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            BackButton(
              color: Colors.white,
            ),
            Text("Hospital Dashboard", //let the spaces be for alignment
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            Spacer(),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "You have got these requests\ncurrently!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
