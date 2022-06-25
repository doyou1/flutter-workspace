import 'dart:math';

class GamePoint {
  Point<int> me;
  Point<int> goal;
  List<Point<int>> wall;

  GamePoint(this.me, this.goal, this.wall);
}