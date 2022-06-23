import 'package:flutter/material.dart';
import 'dart:math';

class GamePainter extends CustomPainter {
  int rows;
  int columns;
  double cellSize;

  GamePainter(this.point, this.goal, this.wall, this.rows, this.columns, this.cellSize);

  Point<int> point;
  Point<int>? goal;
  List<Point<int>>? wall;

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

    final a = Offset(0.0, 0.0);
    final b = Offset(size.width, size.height);
    final rect = Rect.fromPoints(a, b);
    // 전체화면 그림
    canvas.drawRect(rect, blackLine);

    // 내 위치
    // 왼쪽위 (x, y)
    final pa = Offset(cellSize * point.x, cellSize * point.y);
    // 오른쪽아래 (x+1, y+1)
    final pb = Offset(cellSize * (point.x + 1), cellSize * (point.y + 1));
    canvas.drawRect(Rect.fromPoints(pa, pb), blueFilled);

    if(goal != null) {
      // 골
      // 왼쪽위 (x, y)
      final ga = Offset(cellSize * goal!.x, cellSize * goal!.y);
      // 오른쪽아래 (x+1, y+1)
      final gb = Offset(cellSize * (goal!.x + 1), cellSize * (goal!.y + 1));
      canvas.drawRect(Rect.fromPoints(ga, gb), redFilled);
    }

    if(wall != null) {
      for(Point<int> w in wall!) {
        final wa = Offset(cellSize * w.x, cellSize * w.y);
        // 오른쪽아래 (x+1, y+1)
        final wb = Offset(cellSize * (w.x + 1), cellSize * (w.y + 1));
        canvas.drawRect(Rect.fromPoints(wa, wb), blackFilled);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
