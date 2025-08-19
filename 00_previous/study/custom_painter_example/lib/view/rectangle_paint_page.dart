import 'package:flutter/material.dart';

class RectanglePaintPage extends StatelessWidget {
  const RectanglePaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 300,
        child: CustomPaint(
          foregroundPainter: RectanglePainter(),
        ),
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
        ..color = Colors.blue // 사각형 색
        ..strokeWidth = 10  // 사각형 선 굵기
        ..style = PaintingStyle.stroke; // 사각형 안 채우지않음

    print("size.width * 1/6: ${size.width * 1/6}");
    print("size.height * 1/4: ${size.height * 1/4}");
    print("size.width * 5/6: ${size.width * 5/6}");
    print("size.height * 1/6: ${size.height * 3/4}");
    // 사각형의 왼쪽위의 (x,y)
    final a = Offset(size.width * 1/6, size.height * 1/4);
    // 사각형의 오른쪽아래의 (x,y)
    final b = Offset(size.width * 5/6, size.height * 3/4);
    // 무조건 직각사각형
    final rect = Rect.fromPoints(a, b);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}