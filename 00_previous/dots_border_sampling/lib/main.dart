import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DotsButton(
              width: 320,
              height: 72,
              backgroundColor: Color(0xFFFF7033),
              shadowColor: Color(0xFF903F1C),
              child: Center(
                child: Text(
                  "게임등록",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            DotsButton(
              width: 320,
              height: 72,
              backgroundColor: Color(0xFF903F1C),
              shadowColor: Color(0xFF903F1C),
              child: Center(
                child: Text(
                  "게임등록",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            DotsButton(
              width: 320,
              height: 72,
              backgroundColor: Color(0xFFA4928B),
              shadowColor: Color(0xFFA4928B),
              child: Center(
                child: Text(
                  "게임등록",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            DotsButton(
              width: 62,
              height: 62,
              backgroundColor: Color(0xFFFF7033),
              shadowColor: Color(0xFF903F1C),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class DotsButton extends StatelessWidget {
  const DotsButton(
      {super.key,
      required this.width,
      required this.height,
      required this.backgroundColor,
      required this.shadowColor,
      this.borderColor = const Color(0xFFFFFFFF),
      required this.child});

  final double width;
  final double height;
  final Color backgroundColor;
  final Color shadowColor;
  final Color borderColor;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: DotsBorderPainter(
            backgroundColor: backgroundColor,
            shadowColor: shadowColor,
            borderColor: borderColor),
        child: Container(
          child: child,
        ),
      ),
    );
  }
}

class DotsBorderPainter extends CustomPainter {
  final Color shadowColor;
  final Color borderColor;
  final Color backgroundColor;
  DotsBorderPainter(
      {required this.backgroundColor,
      required this.shadowColor,
      required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 2;

    final paint1 = Paint()
      ..color = borderColor // 선의 색
      ..strokeWidth = strokeWidth; // 선의 굵기

    // 1. 사각형의 상, 좌, 우, 하단 라인 그리기
    _drawBorder(canvas, size, strokeWidth, paint1);

    // 2. 각 모서리 대각선 그리기
    _drawDiagonalDots(canvas, size, strokeWidth, paint1);

    // 3. 하단 경로 그리기 (갈색 도형)
    final paint2 = Paint()
      ..color = shadowColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill;
    _drawBottomShape(canvas, size, strokeWidth, paint2);

    // 4. 내부 백그라운드 채우기
    final paint3 = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill;
    _paintBackground(canvas, size, strokeWidth, paint3);
  }

  // 테두리 그리기 함수
  void _drawBorder(Canvas canvas, Size size, double strokeWidth, Paint paint) {
    // 위
    canvas.drawLine(Offset(strokeWidth * 3, 0),
        Offset(size.width - (strokeWidth * 3), 0), paint);

    // 왼쪽
    canvas.drawLine(Offset(0, strokeWidth * 3),
        Offset(0, size.height - (strokeWidth * 3)), paint);

    // 오른쪽
    canvas.drawLine(Offset(size.width, strokeWidth * 3),
        Offset(size.width, size.height - (strokeWidth * 3)), paint);

    // 아래
    canvas.drawLine(Offset(strokeWidth * 3, size.height),
        Offset(size.width - (strokeWidth * 3), size.height), paint);
  }

  // 각 모서리의 대각선 점선 그리기 함수
  void _drawDiagonalDots(
      Canvas canvas, Size size, double strokeWidth, Paint paint) {
    // 왼쪽 위
    _drawSingleDiagonal(canvas, Offset(0, strokeWidth * 3), strokeWidth, paint);
    // 오른쪽 위
    _drawSingleDiagonal(
        canvas, Offset(size.width, strokeWidth * 3), strokeWidth, paint,
        isRight: true);
    // 왼쪽 아래
    _drawSingleDiagonal(
        canvas, Offset(0, size.height - (strokeWidth * 3)), strokeWidth, paint,
        isBottom: true);
    // 오른쪽 아래
    _drawSingleDiagonal(canvas,
        Offset(size.width, size.height - (strokeWidth * 3)), strokeWidth, paint,
        isRight: true, isBottom: true);
  }

  // 개별 모서리의 대각선 점선 그리기 함수
  void _drawSingleDiagonal(
      Canvas canvas, Offset start, double strokeWidth, Paint paint,
      {bool isRight = false, bool isBottom = false}) {
    final factor1 = isRight ? -1 : 1;
    final factor2 = isBottom ? 1 : -1;
    canvas.drawLine(
        start, Offset(start.dx + (factor1 * strokeWidth), start.dy), paint);
    canvas.drawLine(
        Offset(start.dx + (factor1 * strokeWidth),
            start.dy + (factor2 * strokeWidth)),
        Offset(start.dx + (factor1 * 2 * strokeWidth),
            start.dy + (factor2 * strokeWidth)),
        paint);
    canvas.drawLine(
        Offset(start.dx + (factor1 * 2 * strokeWidth),
            start.dy + (factor2 * 2 * strokeWidth)),
        Offset(start.dx + (factor1 * 3 * strokeWidth),
            start.dy + (factor2 * 2 * strokeWidth)),
        paint);
  }

  // 하단 경로 그리기 함수
  void _drawBottomShape(
      Canvas canvas, Size size, double strokeWidth, Paint paint) {
    final path = Path();
    path.moveTo(0, size.height - (strokeWidth * 3));
    path.lineTo(0, size.height + (strokeWidth * 1));
    path.lineTo(strokeWidth, size.height + (strokeWidth * 1));
    path.lineTo(strokeWidth, size.height + (strokeWidth * 2));
    path.lineTo(strokeWidth * 2, size.height + (strokeWidth * 2));
    path.lineTo(strokeWidth * 2, size.height + (strokeWidth * 3));
    path.lineTo(strokeWidth * 3, size.height + (strokeWidth * 3));
    path.lineTo(strokeWidth * 3, size.height + (strokeWidth * 4));
    path.lineTo(
        size.width - (strokeWidth * 3), size.height + (strokeWidth * 4));
    path.lineTo(
        size.width - (strokeWidth * 3), size.height + (strokeWidth * 3));
    path.lineTo(
        size.width - (strokeWidth * 2), size.height + (strokeWidth * 3));
    path.lineTo(
        size.width - (strokeWidth * 2), size.height + (strokeWidth * 2));
    path.lineTo(
        size.width - (strokeWidth * 1), size.height + (strokeWidth * 2));
    path.lineTo(
        size.width - (strokeWidth * 1), size.height + (strokeWidth * 1));
    path.lineTo(size.width, size.height + (strokeWidth * 1));
    path.lineTo(size.width, size.height - (strokeWidth * 2));
    path.lineTo(
        size.width - (strokeWidth * 1), size.height - (strokeWidth * 2));
    path.lineTo(
        size.width - (strokeWidth * 1), size.height - (strokeWidth * 1));
    path.lineTo(
        size.width - (strokeWidth * 2), size.height - (strokeWidth * 1));
    path.lineTo(size.width - (strokeWidth * 2), size.height);
    path.lineTo(size.width - (strokeWidth * 3), size.height);
    path.lineTo(strokeWidth * 3, size.height);
    path.lineTo(strokeWidth * 2, size.height);
    path.lineTo(strokeWidth * 2, size.height - strokeWidth);
    path.lineTo(strokeWidth * 1, size.height - strokeWidth);
    path.lineTo(strokeWidth * 1, size.height - (strokeWidth * 2));
    path.lineTo(0, size.height - (strokeWidth * 2));
    path.lineTo(0, size.height - (strokeWidth * 3));
    path.close();
    canvas.drawPath(path, paint);
  }

  void _paintBackground(
      Canvas canvas, Size size, double strokeWidth, Paint paint) {
    final path = Path();
    path.moveTo(strokeWidth * 3, strokeWidth);
    path.lineTo(size.width - (strokeWidth * 3), strokeWidth);
    path.lineTo(size.width - (strokeWidth * 3), strokeWidth * 2);
    path.lineTo(size.width - (strokeWidth * 2), strokeWidth * 2);
    path.lineTo(size.width - (strokeWidth * 2), strokeWidth * 3);
    path.lineTo(size.width - (strokeWidth * 1), strokeWidth * 3);
    path.lineTo(
        size.width - (strokeWidth * 1), size.height - (strokeWidth * 3));
    path.lineTo(
        size.width - (strokeWidth * 2), size.height - (strokeWidth * 3));
    path.lineTo(
        size.width - (strokeWidth * 2), size.height - (strokeWidth * 2));
    path.lineTo(
        size.width - (strokeWidth * 3), size.height - (strokeWidth * 2));
    path.lineTo(
        size.width - (strokeWidth * 3), size.height - (strokeWidth * 1));
    path.lineTo(
        size.width - (strokeWidth * 4), size.height - (strokeWidth * 1));
    path.lineTo((strokeWidth * 3), size.height - (strokeWidth * 1));
    path.lineTo((strokeWidth * 3), size.height - (strokeWidth * 2));
    path.lineTo((strokeWidth * 2), size.height - (strokeWidth * 2));
    path.lineTo((strokeWidth * 2), size.height - (strokeWidth * 3));
    path.lineTo((strokeWidth * 1), size.height - (strokeWidth * 3));
    path.lineTo((strokeWidth * 1), size.height - (strokeWidth * 4));
    path.lineTo((strokeWidth * 1), (strokeWidth * 3));
    path.lineTo((strokeWidth * 2), (strokeWidth * 3));
    path.lineTo((strokeWidth * 2), (strokeWidth * 2));
    path.lineTo((strokeWidth * 3), (strokeWidth * 2));
    path.lineTo((strokeWidth * 3), (strokeWidth * 1));
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
