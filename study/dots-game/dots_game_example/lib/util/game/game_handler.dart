import 'dart:math';

import 'package:dots_game_example/util/const.dart';
import 'package:dots_game_example/view/game_point.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GameHandler {

  final GamePoint points;
  final AccelerometerEvent accelerometerEvent;

  GameHandler(this.points, this.accelerometerEvent);

  GameHandler moveToLeft() {
    int newX = points.me.x - 1;
    if (newX < 0) newX = 0;

    if (!isWall(Point<int>(newX, points.me.y))) {
      points.me = Point<int>(newX, points.me.y);
    }

    return this;
  }

  GameHandler moveToRight() {
    int newX = points.me.x + 1;
    if (newX > COLUMNS - 1) newX = COLUMNS - 1;

    if (!isWall(Point<int>(newX, points.me.y))) {
      points.me = Point<int>(newX, points.me.y);
    }
    return this;
  }

  GameHandler moveToUp() {
    int newY = points.me.y - 1;
    if (newY < 0) newY = 0;
    if (!isWall(Point<int>(points.me.x, newY))) {
      points.me = Point<int>(points.me.x, newY);
    }
    return this;
  }

  GameHandler moveToDown() {
    int newY = points.me.y + 1;
    if (newY > ROWS - 1) newY = ROWS - 1;
    if (!isWall(Point<int>(points.me.x, newY))) {
      points.me = Point<int>(points.me.x, newY);
    }
    return this;
  }

  bool isGoal() {
    return (points.me.x == points.goal.x && points.me.y == points.goal.y);
  }

  bool isWall(Point<int> newPoint) {
    for (Point<int> w in points.wall) {
      if (newPoint.x == w.x && newPoint.y == w.y) return true;
    }
    return false;
  }

  GameHandler step() {
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

  GamePoint result() {
    return points;
  }

}