import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DotsGamePage(),
    );
  }
}

class DotsGamePage extends StatefulWidget {
  const DotsGamePage({Key? key}) : super(key: key);

  @override
  State<DotsGamePage> createState() => _DotsGamePageState();
}

class _DotsGamePageState extends State<DotsGamePage> {
  double widgetSize = 300.0;
  int rows = 10;
  int columns = 10;
  late math.Point<int> point = math.Point<int>((rows / 2).toInt(), (columns / 2).toInt());
  late double cellSize = (widgetSize / rows).toDouble();

  // late Timer _timer;
  // final int milliseconds = 200;

  @override
  void initState() {
    super.initState();

    // 0.2초마다 reprint
    // _timer = Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
    //   _step();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: widgetSize,
            height: widgetSize,
            child: CustomPaint(
              foregroundPainter: GamePainter(point, rows, columns, cellSize),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: Column(
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        moveToUp();
                      });
                    },
                    child: Icon(Icons.arrow_upward),
                  ),
                ],
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          moveToLeft();
                        });
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          moveToDown();
                        });
                      },
                      child: Icon(Icons.arrow_downward),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          moveToRight();
                        });
                      },
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  void moveToLeft() {
    int newX = point.x - 1;
    if (newX < 0) newX = 0;
    point = math.Point<int>(newX, point.y);
  }

  void moveToRight() {
    int newX = point.x + 1;
    if (newX > columns - 1) newX = columns - 1;
    point = math.Point<int>(newX, point.y);
  }

  void moveToUp() {
    int newY = point.y - 1;
    if (newY < 0) newY = 0;
    point = math.Point<int>(point.x, newY);
  }

  void moveToDown() {
    int newY = point.y + 1;
    if (newY > rows - 1) newY = rows - 1;
    point = math.Point<int>(point.x, newY);
  }
}


class GamePainter extends CustomPainter {
  int rows;
  int columns;
  double cellSize;

  GamePainter(this.point, this.rows, this.columns, this.cellSize);

  math.Point<int> point;

  @override
  void paint(Canvas canvas, Size size) {
    // 전체화면
    final blackLine = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    // 채워짐(snake)
    final blackFilled = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final a = Offset(0.0, 0.0);
    final b = Offset(size.width, size.height);
    final rect = Rect.fromPoints(a, b);
    // 전체화면 그림
    canvas.drawRect(rect, blackLine);

    // 왼쪽위 (x, y)
    final pa = Offset(cellSize * point.x, cellSize * point.y);
    // 오른쪽아래 (x+1, y+1)
    final pb = Offset(cellSize * (point.x + 1), cellSize * (point.y + 1));

    canvas.drawRect(Rect.fromPoints(pa, pb), blackFilled);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
