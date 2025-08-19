import 'dart:math';

import 'package:flutter/material.dart';

import '../../../model/game_point.dart';
import '../../const.dart';

class RandomPainter extends CustomPainter {
  late double cellSize = (WIDGET_SIZE / ROWS).toDouble();
  RandomPainter(
      this.points);
  final GamePoint points;

  @override
  void paint(Canvas canvas, Size size) {
    // 전체화면 style
    final blackLine = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // me style
    final meShape = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // wall style
    final wallShape = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // goal style
    final goalShape = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // sinkhole style
    final sinkholeShape = Paint()
      ..color = Colors.grey
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;


    const a = Offset(0.0, 0.0);
    final b = Offset(size.width, size.height);
    final rect = Rect.fromPoints(a, b);
    // 전체화면 draw
    canvas.drawRect(rect, blackLine);

    final me = points.me;
    final goal = points.goal;
    final wall = points.wall;
    final sinkhole = points.sinkhole;

    // 내 위치
    // 왼쪽위 (x, y)
    final pa = Offset(cellSize * me.x, cellSize * me.y);
    // 오른쪽아래 (x+1, y+1)
    final pb = Offset(cellSize * (me.x + 1), cellSize * (me.y + 1));
    canvas.drawRect(Rect.fromPoints(pa, pb), meShape);

    // 골
    final ga = Offset(cellSize * goal.x, cellSize * goal.y);
    final gb = Offset(cellSize * (goal.x + 1), cellSize * (goal.y + 1));
    canvas.drawRect(Rect.fromPoints(ga, gb), goalShape);

    // 벽
    for (Point<int> w in wall) {
      final wa = Offset(cellSize * w.x, cellSize * w.y);
      // 오른쪽아래 (x+1, y+1)
      final wb = Offset(cellSize * (w.x + 1), cellSize * (w.y + 1));
      canvas.drawRect(Rect.fromPoints(wa, wb), wallShape);
    }

    // 싱크홀
    for (Point<int> s in sinkhole) {
      final sa = Offset(cellSize * s.x, cellSize * s.y);
      // 오른쪽아래 (x+1, y+1)
      final sb = Offset(cellSize * (s.x + 1), cellSize * (s.y + 1));
      canvas.drawRect(Rect.fromPoints(sa, sb), sinkholeShape);
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}