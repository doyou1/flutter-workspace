import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 1/2, size.height * 1/4);
    path.lineTo(0, size.height * 3/4);
    path.lineTo(size.width, size.height * 3/4);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
