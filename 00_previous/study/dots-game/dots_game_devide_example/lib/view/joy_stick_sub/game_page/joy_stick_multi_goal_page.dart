import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick/multi_goal_joy_stick_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/multi_goal_joy_stick_controller.dart';
import '../../../util/const.dart';

class JoyStickMultiGoalPage extends StatefulWidget {
  const JoyStickMultiGoalPage({Key? key}) : super(key: key);

  @override
  State<JoyStickMultiGoalPage> createState() => _JoyStickMultiGoalPageState();
}

class _JoyStickMultiGoalPageState extends State<JoyStickMultiGoalPage> {
  @override
  Widget build(BuildContext context) {
    final c = Get.find<MultiGoalJoyStickController>();
    return GetBuilder(
        init: c,
        builder: (MultiGoalJoyStickController c) {
          return Container(
            child: Center(
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
                  MultiGoalJoyStickView(),
                ],
              ),
            ),
          );
        });
  }
}
