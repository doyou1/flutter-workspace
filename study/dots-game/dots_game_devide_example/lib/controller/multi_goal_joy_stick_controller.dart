import 'package:dots_game_devide_example/controller/count_down_controller.dart';
import 'package:dots_game_devide_example/util/const.dart';
import 'package:dots_game_devide_example/util/game/game_point_random_generator.dart';
import 'package:dots_game_devide_example/util/game/painter/multi_goal_painter.dart';
import 'package:dots_game_devide_example/util/game/point_checker/multi_goal_point_checker.dart';
import 'package:dots_game_devide_example/util/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../util/game/painter/random_painter.dart';
import '../util/game/point_checker/point_checker.dart';

class MultiGoalJoyStickController extends GetxController {
  final count = 0.obs;
  var points = GamePointRandomGenerator.getMultiGoalGamePoint().obs;
  late var painter = CustomPaint(
    foregroundPainter: MultiGoalPainter(points.value),
  );

  late var checker = MultiGoalPointChecker(points.value);
  late BuildContext context;

  // 상
  void moveToUp() {
    final oldMe = points.value.me;
    final newMe = Point<int>(oldMe.x, oldMe.y - 1);
    final flag = checker.step(newMe);
    actionByFlag(flag, newMe);
  }

  // 하
  void moveToDown() {
    final oldMe = points.value.me;
    final newMe = Point<int>(oldMe.x, oldMe.y + 1);
    final flag = checker.step(newMe);
    actionByFlag(flag, newMe);
  }

  // 좌
  void moveToLeft() {
    final oldMe = points.value.me;
    final newMe = Point<int>(oldMe.x - 1, oldMe.y);
    final flag = checker.step(newMe);
    actionByFlag(flag, newMe);
  }

  // 우
  void moveToRight() {
    final oldMe = points.value.me;
    final newMe = Point<int>(oldMe.x + 1, oldMe.y);
    final flag = checker.step(newMe);
    actionByFlag(flag, newMe);
  }

  void actionByFlag(int flag, Point<int> newMe) {
    switch (flag) {
      case WRONG_GOAL_FLAG:
        // goal
        // SnackBarUtil.showWinSnackBar(context);
        // // 이동 -> 스낵바(성공) -> 페이지 리빌드
        // resetPoint();
        break;
      case CORRECT_GOAL_FLAG:
        // goal
        // SnackBarUtil.showWinSnackBar(context);
        // // 이동 -> 스낵바(성공) -> 페이지 리빌드
        // resetPoint();
        break;

      case WALL_FLAG:
        // wall
        // 아무 변화 X
        break;
      case SINK_HOLE_FLAG:
        // SinkHole
        SnackBarUtil.showIsSinkHoleSnackBar(context);
        // 이동 -> 스낵바(실패) -> 페이지 리빌드
        resetPoint();
        break;
      case OK_FLAG:
        // OK
        // 이동
        points.value.me = newMe;
        points.refresh();
        break;
    }
  }

  void resetPoint() {
    points.value = GamePointRandomGenerator.getMultiGoalGamePoint();
    painter = CustomPaint(
      foregroundPainter: MultiGoalPainter(points.value),
    );
    checker = MultiGoalPointChecker(points.value);
    points.refresh();
  }
}
