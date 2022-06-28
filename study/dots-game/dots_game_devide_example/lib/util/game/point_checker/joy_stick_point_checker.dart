import 'dart:math';

import 'package:dots_game_devide_example/controller/joy_stick_sub/joy_stick_controller.dart';
import 'package:dots_game_devide_example/view/joy_stick_page.dart';
import 'package:get/get.dart';

import '../../../model/game_point.dart';
import '../../const.dart';

// 게임 포인트 좌표 확인 클래스
class JoyStickPointChecker {
  final GamePoint points;

  JoyStickPointChecker(this.points);

  // points.value를 매번 쓰는게 불편해서
  // 변하지 않는 goal, wall, sinkhole은 따로 변수에 담아둔다.
  late final goal = points.goal;
  late final wall = points.wall;
  late final sinkhole = points.sinkhole;

  late Point<int> _newPoint;

  int step(Point<int> newPoint) {
    _newPoint = newPoint;

    if (isGoal()) {
      return GOAL_FLAG;
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

  bool isGoal() {
    return (_newPoint.x == goal.x && _newPoint.y == goal.y);
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
