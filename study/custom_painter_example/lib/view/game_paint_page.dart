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
  double widgetSize = 400.0;
  int rows = 30;
  int columns = 30;
  double tinyDiff = 0.5;
  late Point<int> point = Point<int>((rows / 2).toInt(), (columns / 2).toInt());
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

  void moveToLeft() {
    int newX = point.x - 1;
    if (newX < 0) newX = 0;
    point = Point<int>(newX, point.y);
  }

  void moveToRight() {
    int newX = point.x + 1;
    if (newX > columns - 1) newX = columns - 1;
    point = Point<int>(newX, point.y);
  }

  void moveToUp() {
    int newY = point.y - 1;
    if (newY < 0) newY = 0;
    point = Point<int>(point.x, newY);
  }

  void moveToDown() {
    int newY = point.y + 1;
    if (newY > rows - 1) newY = rows - 1;
    point = Point<int>(point.x, newY);
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
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    moveToLeft();
                  });
                },
                child: Icon(Icons.arrow_left),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    moveToUp();
                  });
                },
                child: Icon(Icons.arrow_upward),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    moveToDown();
                  });
                },
                child: Icon(Icons.arrow_downward),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    moveToRight();
                  });
                },
                child: Icon(Icons.arrow_right),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Point<int>? prevPoint;
  AccelerometerEvent? prevAcceleration;

  void _step() {
    if (prevAcceleration == null) {
      prevAcceleration = acceleration;
      return;
    }

    // print("acceleration: $acceleration");
    if (acceleration != null && prevAcceleration != null) {
      int diffX = (acceleration!.x - prevAcceleration!.x).toInt();
      int diffY = (acceleration!.y - prevAcceleration!.y).toInt();
      int diffZ = (acceleration!.z - prevAcceleration!.z).toInt();

      int absX = diffX.abs();
      int absY = diffY.abs();
      int absZ = diffZ.abs();

      // 미미한 변화는 움직이지 않음
      if (absX < tinyDiff && absY < tinyDiff && absZ < tinyDiff) {
        prevAcceleration = acceleration;
        return;
      }

      // X의 변화가 제일 크면
      if (absX > absY && absX > absZ) {
        // 변화가 양수이면, 오른쪽이동  - 핸드폰
        // 변화가 양수이면, 아래쪽이동   - 태블릿
        if (diffX > 0) {
          // moveToRight();
          moveToDown();
        }
        // 변화가 음수이면, 왼쪽이동
        // 변화가 음수이면, 위쪽이동
        else {
          // moveToLeft();
          moveToUp();
        }
      }
      // Y의 변화가 제일 크면
      else if (absY > absX && absY > absZ) {
        // 변화가 양수이면, 아래쪽이동
        // 변화가 양수이면, 오른쪽이동
        if (diffY > 0) {
          // moveToDown();
          moveToRight();
          // 변화가 음수이면, 위쪽 이동
          // 변화가 음수이면, 왼쪽 이동
        } else {
          // moveToUp();
          moveToLeft();
        }
      }
      // Z의 변화가 제일 크면
      else if (absZ > absX && absZ > absY) {
        // print("diffZ: $diffZ");

        if (diffZ > 0) {
          moveToUp();
        } else {
          moveToDown();
        }
      }
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
