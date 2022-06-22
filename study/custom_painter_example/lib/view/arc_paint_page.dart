import 'package:flutter/material.dart';

class ArcPaintPage extends StatelessWidget {
  const ArcPaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 300,
        child: CustomPaint(
          foregroundPainter: ArcPainter(),
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final arc1 = Path();

    // 왼쪽, 시작 점(x,y)
    arc1.moveTo(size.width * 0.2, size.height * 0.2);
    arc1.arcToPoint(
      // 오른쪽, 끝 점(x,y)
      Offset(size.width * 0.8, size.height * 0.2),
      radius: Radius.circular(150.0),
      // true: 위로 그리기(시계방향), false: 아래로 그리기(반시계방향)
      clockwise: false,
    );

    // 이전의 끝 점이 시작점이 됨
    arc1.arcToPoint(
      // 끝점 점(x,y)
      Offset(size.width * 0.6, size.height * 0.2),
      radius: Radius.circular(150.0),
      // true: 위로 그리기(시계방향), false: 아래로 그리기(반시계방향)
      clockwise: false,
    );
    canvas.drawPath(arc1, paint);

    final arc2 = Path();
    // 왼쪽 점(x,y)
    arc2.moveTo(size.width * 0.2, size.height * 0.8);
    arc2.arcToPoint(
      // 오른쪽 점(x,y)
      Offset(size.width * 0.8, size.height * 0.8),
      // circular(param) param이 커질수록 직선에 가까워짐
      // 반지름이 커질수록 선과 같아진다고 생각하자
      radius: Radius.circular(150.0),
      clockwise: true,
    );

    canvas.drawPath(arc2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}