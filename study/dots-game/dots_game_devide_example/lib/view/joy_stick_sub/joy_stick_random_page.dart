import 'package:dots_game_devide_example/controller/joy_stick_sub/joy_stick_controller.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/const.dart';

class JoyStickRandomPage extends StatefulWidget {
  const JoyStickRandomPage({Key? key}) : super(key: key);

  @override
  State<JoyStickRandomPage> createState() => _JoyStickRandomPageState();
}

class _JoyStickRandomPageState extends State<JoyStickRandomPage> {
  // final c = Get.put(JoyStickController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: JoyStickController(),
        builder: (JoyStickController c) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: WIDGET_SIZE,
                  height: WIDGET_SIZE,
                  child: Obx(() => c.painter),
                ),
                JoyStickView(),
              ],
            ),
          );
        });
  }


}
