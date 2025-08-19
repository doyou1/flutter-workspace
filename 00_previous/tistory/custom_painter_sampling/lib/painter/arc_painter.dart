import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    /**
     * 시작점에서 끝점으로
     * 특정 방향으로 선을 그림.(clockwise true: 시계방향, false: 반시계방향)
     * radius는 둥그런 정도가 된다.
     */

    final arc1 = Path();
    // 시작 점(x,y)
    arc1.moveTo(size.width * 0.2, size.height * 0.45);
    arc1.arcToPoint(
      // 끝 점(x,y)
      Offset(size.width * 0.8, size.height * 0.45),
      radius: Radius.circular(150.0),
      // true: 위로 그리기(시계방향), false: 아래로 그리기(반시계방향)
      clockwise: false,
    );

    final arc2 = Path();
    // 시작 점(x,y)
    arc2.moveTo(size.width * 0.2, size.height * 0.55);
    arc2.arcToPoint(
      // 끝 점(x,y)
      Offset(size.width * 0.8, size.height * 0.55),
      // circular(param) param이 커질수록 직선에 가까워짐
      // 반지름이 커질수록 선과 같아진다고 생각하자
      radius: Radius.circular(150.0),
      // true: 위로 그리기(시계방향), false: 아래로 그리기(반시계방향)
      clockwise: true,
    );
    canvas.drawPath(arc1, paint);
    canvas.drawPath(arc2, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
