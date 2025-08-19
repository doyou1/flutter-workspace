import 'package:flutter/material.dart';

class CirclePaintPage extends StatelessWidget {
  const CirclePaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 300,
        child: CustomPaint(
          foregroundPainter: CirclePainter(),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    // 원 중심(x,y)
    final center = Offset(size.width / 2, size.height / 2);
    // 반지름
    final radius = size.width * 1/2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}