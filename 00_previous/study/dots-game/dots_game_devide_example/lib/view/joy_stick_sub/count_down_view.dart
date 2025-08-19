import 'package:dots_game_devide_example/util/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/accelerometer_controller.dart';
import '../../controller/count_down_controller.dart';

class CountDownView extends StatelessWidget {
  const CountDownView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cc = Get.find<CountDownController>();
    cc.context = context;

    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: cc.toggle,
              child: Obx(
                () => !(cc.isRunning.value)
                    ? Text(START_COUNT_DOWN_TEXT)
                    : Text("$STOP_COUNT_DOWN_TEXT: ${cc.currentSecond.value}s ${cc.gameCount.value}판 남음"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
