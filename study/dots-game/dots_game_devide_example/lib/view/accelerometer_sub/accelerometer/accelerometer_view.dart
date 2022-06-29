import 'package:dots_game_devide_example/controller/accelerometer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccelerometerView extends StatelessWidget {
  AccelerometerView({this.isRunning = true, Key? key}) : super(key: key);

  bool isRunning;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccelerometerController>(
        init: Get.find<AccelerometerController>(),
        builder: (AccelerometerController c) {
          c.context = context;
          c.startAccelerometerEvent();
          return Container(
            height: 150,
            child: Column(children: [
              Obx(() => Text(
                  "x: ${c.accelerometerEvent.value.x}, y: ${c.accelerometerEvent.value.y}, z: ${c.accelerometerEvent.value.z}"),
              ),
              Text("상하좌우로 움직여보세요!"),
            ]),
          );
        });
  }
}
