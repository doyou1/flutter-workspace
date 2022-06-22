import 'package:flutter/material.dart';

class RoundedRectanglePaintPage extends StatelessWidget {
  const RoundedRectanglePaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 300,
        child: CustomPaint(
          foregroundPainter: RoundedRectanglePainter(),
        ),
      ),
    );
  }
}

class RoundedRectanglePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    // 사각형의 왼쪽위의 (x,y)
    final a = Offset(size.width * 1/6, size.height * 1/4);
    // 사각형의 오른쪽아래의 (x,y)
    final b = Offset(size.width * 5/6, size.height * 3/4);
    final rect = Rect.fromPoints(a, b);
    final radius = Radius.circular(32.0);

    // 사각형에 radius 추가
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

