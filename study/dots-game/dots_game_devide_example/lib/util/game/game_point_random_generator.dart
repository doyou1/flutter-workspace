import 'dart:math';


import '../../model/game_point.dart';
import '../const.dart';

class GamePointRandomGenerator {
  static GamePoint getGamePoint() {
    Point<int> me = Point<int>(ROWS ~/ 2, COLUMNS ~/ 2);

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

    List<Point<int>> sinkhole = [];

    while (true) {
      if (sinkhole.length == SINK_HOLE_COUNT) break;
      int randomX = Random().nextInt(ROWS - 1);
      int randomY = Random().nextInt(COLUMNS - 1);

      if (me.x == randomX && me.y == randomY) {
        continue;
      } else if (goal.x == randomX && goal.y == randomY) {
        continue;
      } else if (wall.contains(Point(randomX, randomY))) {
        continue;
      } else {
        sinkhole.add(Point<int>(randomX, randomY));
      }
    }

    return GamePoint(me, goal, wall, sinkhole);
  }

  // static MultiGoalGamePoint getMultiGoalGamePoint() {
  //   Point<int> me = Point<int>(ROWS ~/ 2, COLUMNS ~/ 2);
  //
  //   List<Goal> goal = [];
  //   while (true) {
  //     if (goal.length == GOAL_COUNT) break;
  //     int randomX = Random().nextInt(ROWS - 1);
  //     int randomY = Random().nextInt(COLUMNS - 1);
  //
  //     if (me.x == randomX && me.y == randomY) {
  //       continue;
  //     } else {
  //       int index = goal.length;
  //       goal.add(Goal(index, Point<int>(randomX, randomY)));
  //     }
  //   }
  //
  //   List<Point<int>> wall = [];
  //
  //   while (true) {
  //     if (wall.length == WALL_COUNT) break;
  //     int randomX = Random().nextInt(ROWS - 1);
  //     int randomY = Random().nextInt(COLUMNS - 1);
  //
  //     if (me.x == randomX && me.y == randomY) {
  //       continue;
  //     } else {
  //       bool isContain = false;
  //       for (var item in goal) {
  //         if (item.point == Point(randomX, randomY)) isContain = true;
  //       }
  //       if(isContain) continue;
  //       wall.add(Point<int>(randomX, randomY));
  //     }
  //   }
  //
  //   List<Point<int>> sinkhole = [];
  //   while (true) {
  //     if (sinkhole.length == SINK_HOLE_COUNT) break;
  //     int randomX = Random().nextInt(ROWS - 1);
  //     int randomY = Random().nextInt(COLUMNS - 1);
  //
  //     if (me.x == randomX && me.y == randomY) {
  //       continue;
  //     } else if (wall.contains(Point(randomX, randomY))) {
  //       continue;
  //     } else {
  //       bool isContain = false;
  //       for (var item in goal) {
  //         if (item.point == Point(randomX, randomY)) isContain = true;
  //       }
  //
  //       if(isContain) continue;
  //       sinkhole.add(Point<int>(randomX, randomY));
  //     }
  //   }
  //
  //   return MultiGoalGamePoint(me, goal, wall, sinkhole);
  // }
}
