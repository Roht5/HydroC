import 'package:flutter/material.dart';

class TitleDescriptionRichText extends StatelessWidget {
  String title;
  String description;
  TitleDescriptionRichText(this.title, this.description, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextSpan(
              text: description,
              style: const TextStyle(overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
