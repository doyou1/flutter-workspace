import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print("size: $size");

    final paint = Paint()
      ..color = Colors.amber // 선의 색
      ..strokeCap = StrokeCap.round // 선의 stroke를 둥글게
      ..strokeWidth = 10; // 선의 굵기

    canvas.drawLine(
      // a점의 (x, y)
      Offset(0, size.height * 1 / 2),
      // b점의 (x, y)
      Offset(size.width, size.height * 1 / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
