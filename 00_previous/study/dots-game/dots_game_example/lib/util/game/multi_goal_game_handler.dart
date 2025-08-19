import 'dart:math';

import 'package:dots_game_example/util/const.dart';
import 'package:dots_game_example/model/game_point.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../model/multi_goal_game_point.dart';

// 게임 포인트 좌표 조작 클래스
class MultiGoalGameHandler {
  final MultiGoalGamePoint points;
  AccelerometerEvent accelerometerEvent;

  MultiGoalGameHandler(this.points, this.accelerometerEvent);

  // methodchaining
  MultiGoalGameHandler step() {
    if (accelerometerEvent.x < -1.0) {
      moveToUp();
    } else if (-1.0 < accelerometerEvent.x && accelerometerEvent.x < 1.0) {
      // no action
    } else if (1.0 < accelerometerEvent.x) {
      moveToDown();
    }

    if (accelerometerEvent.y < -1.0) {
      moveToLeft();
    } else if (-1.0 < accelerometerEvent.y && accelerometerEvent.y < 1.0) {
      // no action
    } else if (1.0 < accelerometerEvent.y) {
      moveToRight();
    }
    return this;
  }

  // methodchaining
  // step 결과에 따라 변경된 GamePoint 객체 반환
  MultiGoalGamePoint result() {
    return points;
  }

  // methodchaining
  MultiGoalGameHandler moveToLeft() {
    int newX = points.me.x - 1;
    if (newX < 0) newX = 0;

    if (!isWall(Point<int>(newX, points.me.y))) {
      if (isCorrectGoal(Point<int>(newX, points.me.y))) {
      } else if (isWrongGoal(Point<int>(newX, points.me.y))) {
        return this;
      }

      points.me = Point<int>(newX, points.me.y);
    }

    return this;
  }

  // methodchaining
  MultiGoalGameHandler moveToRight() {
    int newX = points.me.x + 1;
    if (newX > COLUMNS - 1) newX = COLUMNS - 1;

    if (!isWall(Point<int>(newX, points.me.y))) {
      if (isCorrectGoal(Point<int>(newX, points.me.y))) {
      } else if (isWrongGoal(Point<int>(newX, points.me.y))) {
        return this;
      }
      points.me = Point<int>(newX, points.me.y);
    }

    return this;
  }

  // methodchaining
  MultiGoalGameHandler moveToUp() {
    int newY = points.me.y - 1;
    if (newY < 0) newY = 0;

    if (!isWall(Point<int>(points.me.x, newY))) {
      if (isCorrectGoal(Point<int>(points.me.x, newY))) {
      } else if (isWrongGoal(Point<int>(points.me.x, newY))) {
        return this;
      }
      points.me = Point<int>(points.me.x, newY);
    }

    return this;
  }

  // methodchaining
  MultiGoalGameHandler moveToDown() {
    int newY = points.me.y + 1;
    if (newY > ROWS - 1) newY = ROWS - 1;
    if (!isWall(Point<int>(points.me.x, newY))) {
      if (isCorrectGoal(Point<int>(points.me.x, newY))) {
      } else if (isWrongGoal(Point<int>(points.me.x, newY))) {
        return this;
      }
      points.me = Point<int>(points.me.x, newY);
    }
    return this;
  }

  bool isSuccess() {
    return points.goal.isEmpty;
  }

  bool isWall(Point<int> newPoint) {
    for (Point<int> w in points.wall) {
      if (newPoint.x == w.x && newPoint.y == w.y) return true;
    }
    return false;
  }

  bool isSinkHole() {
    for (Point<int> s in points.sinkhole) {
      if (points.me.x == s.x && points.me.y == s.y) return true;
    }
    return false;
  }

  bool isCorrectGoal(Point<int> newPoint) {
    int correctGoalX = points.goal[0].point.x;
    int correctGoalY = points.goal[0].point.y;
    if (newPoint.x == correctGoalX && newPoint.y == correctGoalY) {
      points.goal.removeAt(0);
      return true;
    }
    return false;
  }

  // 지금 들어가면 안되는 골에 들어 갔을 때
  bool isWrongGoal(Point<int> newPoint) {
    if (points.goal.length == 1) return false;
    bool result = false;
    for (int i = 0; i < points.goal.length; i++) {
      Point<int> g = points.goal[i].point;
      if (newPoint.x == g.x && newPoint.y == g.y) result = true;
    }
    return result;
  }
}
