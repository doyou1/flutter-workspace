import 'dart:math';

import 'package:dots_game_example/view/game_point.dart';

import '../const.dart';

class GamePointRandomGenerator {

  static GamePoint getGamePoint() {
    Point<int> me = Point<int>(ROWS~/2, COLUMNS~/2);

    Point<int>? goal;

    while (true) {
      int randomX = Random().nextInt(ROWS - 1);
      int randomY = Random().nextInt(COLUMNS - 1);

      if (me.x == randomX && me.y == randomY) {
        continue;
      } else {
         goal = Point<int>(randomX, randomY);
         break;
      }
    }

    List<Point<int>> wall = [];

    while (true) {
      if (wall.length == WALL_COUNT) break;
      int randomX = Random().nextInt(ROWS - 1);
      int randomY = Random().nextInt(COLUMNS - 1);

      if (me.x == randomX && me.y == randomY) {
        continue;
      } else if (goal.x == randomX && goal.y == randomY) {
        continue;
      } else {
        wall.add(Point<int>(randomX, randomY));
      }
    }

    return GamePoint(me, goal, wall);
  }
}