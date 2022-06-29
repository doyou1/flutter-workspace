import 'package:dots_game_devide_example/controller/accelerometer_controller.dart';
import 'package:dots_game_devide_example/view/accelerometer_sub/accelerometer/accelerometer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/const.dart';

class AccelerometerRandomPage extends StatefulWidget {
  const AccelerometerRandomPage({Key? key}) : super(key: key);

  @override
  State<AccelerometerRandomPage> createState() => _AccelerometerRandomPageState();
}

class _AccelerometerRandomPageState extends State<AccelerometerRandomPage> {

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
                  AccelerometerView(),
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
