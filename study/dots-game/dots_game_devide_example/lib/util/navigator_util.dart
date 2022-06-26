import 'package:flutter/material.dart';

import '../view/accelerometer_page.dart';
import '../view/joy_stick_page.dart';

class NavigatorUtil {

  static void moveToJoyStickPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const JoyStickPage();
    }));
  }
  static void moveToAccelerometerPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const AccelerometerPage();
    }));
  }
}