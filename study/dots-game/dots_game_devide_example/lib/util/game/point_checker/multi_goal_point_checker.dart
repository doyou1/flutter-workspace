import 'dart:math';

import 'package:dots_game_devide_example/controller/joy_stick_controller.dart';
import 'package:dots_game_devide_example/model/multi_goal_game_point.dart';
import 'package:dots_game_devide_example/util/game/point_checker/point_checker.dart';
import 'package:dots_game_devide_example/view/joy_stick_page.dart';
import 'package:get/get.dart';

import '../../../model/game_point.dart';
import '../../const.dart';

// 게임 포인트 좌표 확인 클래스
class MultiGoalPointChecker {
  final MultiGoalGamePoint points;

  MultiGoalPointChecker(this.points);

  // points.value를 매번 쓰는게 불편해서
  // 변하지 않는 goal, wall, sinkhole은 따로 변수에 담아둔다.
  late final goal = points.goal;
  late final wall = points.wall;
  late final sinkhole = points.sinkhole;

  late Point<int> _newPoint;

  int step(Point<int> newPoint) {
    _newPoint = newPoint;

    if (isWrongGoal()) {
      return WRONG_GOAL_FLAG;
    } else if (isCorrectGoal()) {
      return CORRECT_GOAL_FLAG;
    } else if (isWall()) {
      return WALL_FLAG;
    } else if (isSinkHole()) {
      // newPoint가 싱크홀이라면
      // 이동 후 죽음
      return SINK_HOLE_FLAG;
    } else {
      // 아무 것도 아닌 이동할 수 있는 point이기에
      return OK_FLAG;
    }
  }

  bool isWrongGoal() {
    if (points.goal.length == 1) return false;
    bool result = false;
    for (int i = 1; i < points.goal.length; i++) {
      Point<int> g = points.goal[i].point;
      if (_newPoint.x == g.x && _newPoint.y == g.y) result = true;
    }
    return result;
  }

  bool isCorrectGoal() {
    int correctGoalX = points.goal[0].point.x;
    int correctGoalY = points.goal[0].point.y;
    if (_newPoint.x == correctGoalX && _newPoint.y == correctGoalY) {
      // points.goal.removeAt(0);
      return true;
    }
    return false;
  }

  bool isWall() {
    for (Point<int> w in wall) {
      if (_newPoint.x == w.x && _newPoint.y == w.y) return true;
    }
    return false;
  }

  bool isSinkHole() {
    for (Point<int> s in sinkhole) {
      if (_newPoint.x == s.x && _newPoint.y == s.y) return true;
    }
    return false;
  }
}
