import 'package:dots_game_devide_example/controller/accelerometer_controller.dart';
import 'package:dots_game_devide_example/controller/multi_goal_accelerometer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiGoalAccelerometerView extends StatelessWidget {
  MultiGoalAccelerometerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultiGoalAccelerometerController>(
        init: Get.find<MultiGoalAccelerometerController>(),
        builder: (MultiGoalAccelerometerController c) {
          c.context = context;
          c.startAccelerometerEvent();
          return Container(
            height: 150,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Obx(() => Text(
                    "x: ${c.accelerometerEvent.value.x}, y: ${c.accelerometerEvent.value.y}, z: ${c.accelerometerEvent.value.z}"),
                ),
                Text("상하좌우로 움직여보세요!"),
              ]),
            ),
          );
        });
  }
}
