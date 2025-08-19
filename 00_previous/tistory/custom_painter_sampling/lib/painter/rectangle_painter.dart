import 'package:flutter/material.dart';

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // 선의 색
      ..strokeWidth = 10  // 선의 굵기
      ..style = PaintingStyle.stroke; // 안을 채우지않음
      // ..style = PaintingStyle.fill; // 안을 채움

    // left top(x,y) of rectangle
    final a = Offset(0, size.height * 1/4);
    // right down(x,y) of rectangle
    final b = Offset(size.width, size.height * 3/4);
    final rect = Rect.fromPoints(a, b);

    canvas.drawRect(
      rect,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
