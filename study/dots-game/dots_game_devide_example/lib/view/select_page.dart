import 'package:dots_game_devide_example/util/const.dart';
import 'package:dots_game_devide_example/util/navigator_util.dart';
import 'package:dots_game_devide_example/view/accelerometer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'joy_stick_page.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () {
              NavigatorUtil.moveToJoyStickPage(context);
              // Get.to(JoyStickPage());
            }, child: const Text(SELECT_JOYSTICK_BUTTON_TEXT)),
            ElevatedButton(onPressed: () {
              NavigatorUtil.moveToAccelerometerPage(context);
              // Get.to(AccelerometerPage());
            }, child: const Text(SELECT_ACCELEROMETER_BUTTON_TEXT)),
          ],
        ),
      ),
    );
  }
}
