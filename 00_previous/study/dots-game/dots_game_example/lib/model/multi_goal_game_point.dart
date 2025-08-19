import 'dart:math';

import 'package:dots_game_example/model/goal.dart';

class MultiGoalGamePoint {
  Point<int> me;
  List<Goal> goal;
  List<Point<int>> wall;
  List<Point<int>> sinkhole;

  MultiGoalGamePoint(this.me, this.goal, this.wall, this.sinkhole);
}