import 'package:ambulance_tracker/screens/Welcome/welcome_screen.dart';
import 'package:ambulance_tracker/screens/choice_page.dart';
import 'package:flutter/material.dart';

import '../firebase/auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const ChoicePage();
        } else {
          return WelcomeScreen();
        }
      },
    );
  }
}
