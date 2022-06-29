import 'package:dots_game_devide_example/controller/multi_goal_accelerometer_controller.dart';
import 'package:dots_game_devide_example/view/accelerometer_sub/accelerometer/multi_goal_accelerometer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/const.dart';
import 'accelerometer/accelerometer_view.dart';

class AccelerometerMultiGoalPage extends StatefulWidget {
  const AccelerometerMultiGoalPage({Key? key}) : super(key: key);

  @override
  State<AccelerometerMultiGoalPage> createState() =>
      _AccelerometerMultiGoalPageState();
}

class _AccelerometerMultiGoalPageState
    extends State<AccelerometerMultiGoalPage> {
  @override
  Widget build(BuildContext context) {
    final c = Get.find<MultiGoalAccelerometerController>();
    return GetBuilder(
        init: c,
        builder: (MultiGoalAccelerometerController c) {
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
                  MultiGoalAccelerometerView(),
                ],
              ),
            ),
          );
        });
  }
}
