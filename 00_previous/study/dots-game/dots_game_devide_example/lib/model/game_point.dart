import 'dart:math';

class GamePoint {
  Point<int> me;
  Point<int> goal;
  List<Point<int>> wall;
  List<Point<int>> sinkhole;

  GamePoint(this.me, this.goal, this.wall, this.sinkhole);
}