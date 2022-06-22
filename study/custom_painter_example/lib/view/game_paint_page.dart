import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GamePaintPage extends StatefulWidget {
  GamePaintPage({Key? key}) : super(key: key);

  @override
  State<GamePaintPage> createState() => _GamePaintPageState();
}

class _GamePaintPageState extends State<GamePaintPage> {
  Point<int> point = Point<int>(0, 0);
  double widgetSize = 400.0;
  int rows = 10;
  int columns = 10;
  late double cellSize = (widgetSize / rows).toDouble();

  AccelerometerEvent? acceleration;
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 가속도계 정보 취득 리스너
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        acceleration = event;
      });
    });

    // 0.2초마다 실행
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      _step();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            width: widgetSize,
            height: widgetSize,
            child: CustomPaint(
              foregroundPainter: GamePainter(point, rows, columns, cellSize),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                point = Point<int>(0, 0);
              });
            },
            child: Text("move"),
          ),
        ],
      ),
    );
  }

  Point<int>? prev;
  void _step() {
    // print("acceleration: $acceleration");
    if (acceleration != null) {
      int currentX = acceleration!.x.toInt();
      int currentY = acceleration!.y.toInt();
      if(prev != null) {
        if(currentX - prev!.x == 0 || currentY - prev!.y == 0) {
          // 미미한 변화
          return;
        } else {
          int moveX = currentX - prev!.x;
          int moveY = currentX - prev!.y;

          int nextX = -1;
          if(prev!.x + moveX > rows) {
            nextX = rows;
          } else {
            nextX = prev!.x + moveX;
          }

          int nextY = -1;
          if(prev!.y + moveY > columns) {
            nextY = columns;
          } else {
            nextY = prev!.y + moveY;
          }

          int diffX = (nextX.abs() - point.x.abs()).abs();
          int diffY = (nextY.abs() - point.y.abs()).abs();

          if(diffX > diffY) {
            point = Point<int>(nextX, point.y);
          } else if(diffX < diffY) {
            point = Point<int>(point.x, nextY);
          } else {
            point = Point<int>(nextX, nextY);

          }
        }
      } else {
        prev = Point<int>(acceleration!.x.toInt(), acceleration!.y.toInt());
        return;
      }
    } else {
      return;
    }
  }
}

class GamePainter extends CustomPainter {
  int rows;
  int columns;
  double cellSize;

  GamePainter(this.point, this.rows, this.columns, this.cellSize);

  Point<int> point;

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
