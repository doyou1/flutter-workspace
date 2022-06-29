import 'package:dots_game_devide_example/controller/count_down_controller.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/count_down_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dots_game_devide_example/controller/joy_stick_controller.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick/joy_stick_view.dart';
import '../../../util/const.dart';

class JoyStickCountDownPage extends StatefulWidget {
  const JoyStickCountDownPage({Key? key}) : super(key: key);

  @override
  State<JoyStickCountDownPage> createState() => _JoyStickCountDownPageState();
}

class _JoyStickCountDownPageState extends State<JoyStickCountDownPage> {
  @override
  Widget build(BuildContext context) {
    final cc = Get.find<CountDownController>();
    cc.context = context;
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
                CountDownView(),
                SizedBox(
                  height: SIZEDBOX_HEIGHT,
                ),
              Obx(() => JoyStickView(isRunning: cc.isRunning.value)),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
