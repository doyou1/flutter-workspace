import 'package:dots_game_devide_example/view/joy_stick_sub/count_down_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../controller/accelerometer_controller.dart';
import '../../util/const.dart';
import 'accelerometer/accelerometer_view.dart';

class AccelerometerCountDownPage extends StatefulWidget {
  const AccelerometerCountDownPage({Key? key}) : super(key: key);

  @override
  State<AccelerometerCountDownPage> createState() => _AccelerometerCountDownPageState();
}

class _AccelerometerCountDownPageState extends State<AccelerometerCountDownPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<AccelerometerController>(),
        builder: (AccelerometerController c) {
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
                  CountDownView(),
                  AccelerometerView(),
                ],
              ),
            ),
          );
        });
  }
}
