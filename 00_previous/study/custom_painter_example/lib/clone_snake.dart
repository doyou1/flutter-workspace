import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

/**
 * 부모 위젯으로부터
 * 픽셀화면의 행과 열의 개수 및 셀의 크기를 정함
 */
class Snake extends StatefulWidget {
  Snake({Key? key, this.rows = 20, this.columns = 20, this.cellSize = 10.0}) : super(key: key) {
    assert(10 <= rows);     // row의 크기가 10이상
    assert(10 <= columns);  // column의 크기가 10이상
    assert(5.0 <= cellSize);  // cell size가 5.0이상
  }

  final int rows;
  final int columns;
  final double cellSize;

  @override
  State<Snake> createState() => _SnakeState(rows, columns, cellSize);
}

/**
 * 정해진 행, 열, 셀의 크기에 따른
 * 게임 위젯 생성, 관련 가속도계 리스너 추가, RePaint 타이머 추가
 */
class _SnakeState extends State<Snake> {
  double cellSize;
  GameState? state;
  AccelerometerEvent? acceleration;
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  late Timer _timer;

  _SnakeState(int rows, int columns, this.cellSize) {
    state = GameState(rows, columns);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // cellSize를 기준으로 GameState그리자
      painter: SnakeBoardPainter(state, cellSize),
    );
  }

  @override
  void initState() {
    super.initState();
    // 가속도계 정보 취득 리스너 등록(stream)
    _streamSubscription = accelerometerEvents.listen((event) { 
      setState(() {
        acceleration = event;
      });
    });
    
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) { 
      setState(() {
        // 0.2초마다 변경된 가속도계 데이터에 따라 새롭게 RePaint
        _step();
      });
    });
  }
  
  void _step() {
    // 데이터가 없다면 null
    final newDirection = acceleration == null
        ? null
        // 1.0으로 미미한 움직임이라면,
        : acceleration!.x.abs() < 1.0 && acceleration!.y.abs() < 1.0
        ? null
        // y 움직임이 더 크다면 (true: y-상하이동, false: x-좌우이동)
        : (acceleration!.x.abs() < acceleration!.y.abs())
        ? math.Point<int>(0, acceleration!.y.sign.toInt())
        : math.Point<int>(-acceleration!.x.sign.toInt(), 0);
    state!.step(newDirection);
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
    _timer.cancel();
  }
}

class SnakeBoardPainter extends CustomPainter {

  GameState? state;
  double cellSize;

  SnakeBoardPainter(this.state, this.cellSize);

  @override
  void paint(Canvas canvas, Size size) {

    // 전체화면
    final blackLine = Paint()..color = Colors.black;
    // 채워짐(snake)
    final blackFilled = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromPoints(Offset.zero, size.bottomLeft(Offset.zero)),
      blackLine,
    );

    for (final p in state!.body) {
      // 왼쪽위 (x, y)
      final a = Offset(cellSize * p.x, cellSize * p.y);
      // 오른쪽아래 (x+1, y+1)
      final b = Offset(cellSize * (p.x + 1), cellSize * (p.y + 1));

      canvas.drawRect(Rect.fromPoints(a, b), blackFilled);
    }
  }

  // Repaint를 가능하게 설정!
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GameState {
  int rows;
  int columns;
  late int snakeLength;

  GameState(this.rows, this.columns) {
    snakeLength = math.min(rows, columns) - 5;
  }

  List<math.Point<int>> body = <math.Point<int>>[const math.Point<int>(0, 0)];
  math.Point<int> direction = const math.Point<int>(1, 0);

  void step(math.Point<int>? newDirection) {
    var next = body.last + direction;
    next = math.Point<int>(next.x % columns, next.y % rows);
    body.add(next);
    if(body.length > snakeLength) body.removeAt(0);
    direction = newDirection ?? direction;
  }
}