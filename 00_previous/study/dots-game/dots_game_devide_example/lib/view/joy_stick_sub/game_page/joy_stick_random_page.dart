import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dots_game_devide_example/controller/joy_stick_controller.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick/joy_stick_view.dart';
import '../../../util/const.dart';

class JoyStickRandomPage extends StatefulWidget {
  const JoyStickRandomPage({Key? key}) : super(key: key);

  @override
  State<JoyStickRandomPage> createState() => _JoyStickRandomPageState();
}

class _JoyStickRandomPageState extends State<JoyStickRandomPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<JoyStickController>(),
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
                SizedBox(
                  height: SIZEDBOX_HEIGHT,
                ),
                JoyStickView(),
              ],
            ),
          );
        });
  }

  @override
  void dispose() async {
    super.dispose();
  }
}
