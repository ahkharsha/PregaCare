import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const OPENAI_API_KEY = "Give_Your_API_KEY";

Color primaryColor = Color.fromARGB(255, 208, 9, 248);

void goTo(BuildContext context, Widget nextScreen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}

dialogueBox(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text),
    ),
  );
}

Widget progressIndicator(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: primaryColor,
      color: Colors.red,
      strokeWidth: 7,
    ),
  );
}


// progressIndicator(BuildContext context) {
//   showDialog(
//     barrierDismissible: false,
//       context: context,
//       builder: (context) => Center(child: CircularProgressIndicator(
//         backgroundColor: primaryColor,
//         color: Colors.red,
//         strokeWidth: 7,
//       )));
// }
