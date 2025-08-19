import 'dart:math';

import 'goal.dart';

class MultiGoalGamePoint {
  Point<int> me;
  List<Goal> goal;
  List<Point<int>> wall;
  List<Point<int>> sinkhole;

  MultiGoalGamePoint(this.me, this.goal, this.wall, this.sinkhole);
}