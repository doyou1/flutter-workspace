import 'package:dots_game_devide_example/controller/accelerometer_controller.dart';
import 'package:dots_game_devide_example/controller/joy_stick_controller.dart';
import 'package:dots_game_devide_example/controller/multi_goal_accelerometer_controller.dart';
import 'package:dots_game_devide_example/util/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../util/const.dart';

class CountDownController extends GetxController {
  var isRunning = false.obs;
  var currentSecond = COUNT_DOWN_SECONDS.obs;
  var gameCount = GAME_COUNT.obs;

  Timer? timer;
  late BuildContext context;

  @override
  void onInit() {
    super.onInit();
    final cc = Get.find<AccelerometerController>();
    cc.isCountDownPage.value = true;
    cc.isCountDownPage.refresh();
  }

  void toggle() {
    isRunning.value = !(isRunning.value);

    if (isRunning.value) {
      startCountDown();
    } else {
      stopCountDown();
    }

    isRunning.refresh();
  }

  void startCountDown() {
    resetGameState();

    final cc = Get.find<AccelerometerController>();
    cc.isRunning.value = true;
    cc.isRunning.refresh();

    timer ??= Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentSecond.value == 0) {
        SnackBarUtil.showCountDownFailSnackBar(context);
        stopCountDown();
      } else {
        currentSecond.value--;
        currentSecond.refresh();
      }
    });
  }

  void stopCountDown() {
    if (timer != null) {
      timer?.cancel();
      timer = null;

      resetGameState();
      isRunning.value = false;
      isRunning.refresh();

      if(Get.isRegistered<AccelerometerController>()) {
        final cc = Get.find<AccelerometerController>();
        if (!cc.isClosed) {
          cc.isRunning.value = false;
          cc.isRunning.refresh();
          cc.resetPoint();
        }
      }

      if(Get.isRegistered<JoyStickController>()) {
        final jc = Get.find<JoyStickController>();
        if (!jc.isClosed) {
          jc.resetPoint();
        }
      }
      SnackBarUtil.showCountDownFailSnackBar(context);
    }
  }

  void resetGameState() {
    currentSecond.value = COUNT_DOWN_SECONDS;
    currentSecond.refresh();
    gameCount.value = GAME_COUNT;
    gameCount.refresh();
  }

  void checkIsSuccess() {
    if (gameCount.value == 0) {
      stopCountDown();
      SnackBarUtil.showCountDownSuccessSnackBar(context);
    }
  }
}
