import 'package:flutter/material.dart';

class LinePaintPage extends StatelessWidget {
  const LinePaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 300,
        child: CustomPaint(
          foregroundPainter: LinePainter(),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber  // 선의 색
      ..strokeCap = StrokeCap.round // 선의 구석을 둥글게
      ..strokeWidth = 10; // 선의 굵기

    canvas.drawLine(
      // a점(x, y)
      Offset(size.width * 1 / 6, size.height * 1 / 2),
      // b점(x, y)
      Offset(size.width * 5 / 6, size.height * 1 / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
