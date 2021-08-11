import 'package:flutter/material.dart';

class Navigation {
  static Future changeScreen(
      {required BuildContext context, required Widget screen, type}) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  static Future changeScreenReplacement(
      {required BuildContext context, required Widget screen}) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }
}
