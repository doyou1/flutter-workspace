import 'package:dots_game_example/util/const.dart';
import 'package:dots_game_example/view/game_point.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GamePainter extends CustomPainter {
  late double cellSize = (WIDGET_SIZE / ROWS).toDouble();

  GamePainter(
      this.points);

  final GamePoint points;

  @override
  void paint(Canvas canvas, Size size) {
    // 전체화면
    final blackLine = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final blueFilled = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final blackFilled = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final redFilled = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    const a = Offset(0.0, 0.0);
    final b = Offset(size.width, size.height);
    final rect = Rect.fromPoints(a, b);
    // 전체화면 그림
    canvas.drawRect(rect, blackLine);

    final me = points.me;
    final goal = points.goal;
    final wall = points.wall;

    // 내 위치
    // 왼쪽위 (x, y)
    final pa = Offset(cellSize * me.x, cellSize * me.y);
    // 오른쪽아래 (x+1, y+1)
    final pb = Offset(cellSize * (me.x + 1), cellSize * (me.y + 1));
    canvas.drawRect(Rect.fromPoints(pa, pb), blueFilled);

    // 골
    final ga = Offset(cellSize * goal.x, cellSize * goal.y);
    final gb = Offset(cellSize * (goal.x + 1), cellSize * (goal.y + 1));
    canvas.drawRect(Rect.fromPoints(ga, gb), redFilled);

    // 벽
    for (Point<int> w in wall) {
      final wa = Offset(cellSize * w.x, cellSize * w.y);
      // 오른쪽아래 (x+1, y+1)
      final wb = Offset(cellSize * (w.x + 1), cellSize * (w.y + 1));
      canvas.drawRect(Rect.fromPoints(wa, wb), blackFilled);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
