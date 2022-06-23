import 'package:flutter/material.dart';
import 'dart:math';

class GamePainter extends CustomPainter {
  int rows;
  int columns;
  double cellSize;

  GamePainter(this.point, this.rows, this.columns, this.cellSize);

  Point<int> point;

  @override
  void paint(Canvas canvas, Size size) {
    // 전체화면
    final blackLine = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    // 채워짐(snake)
    final blackFilled = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final a = Offset(0.0, 0.0);
    final b = Offset(size.width, size.height);
    final rect = Rect.fromPoints(a, b);
    // 전체화면 그림
    canvas.drawRect(rect, blackLine);

    // 왼쪽위 (x, y)
    final pa = Offset(cellSize * point.x, cellSize * point.y);
    // 오른쪽아래 (x+1, y+1)
    final pb = Offset(cellSize * (point.x + 1), cellSize * (point.y + 1));

    canvas.drawRect(Rect.fromPoints(pa, pb), blackFilled);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
