import 'package:dots_game_example/util/const.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../model/multi_goal_game_point.dart';

// 게임 화면 위젯 그리는 클래스
class MultiGoalGamePainter extends CustomPainter {
  late double cellSize = (WIDGET_SIZE / ROWS).toDouble();

  MultiGoalGamePainter(
      this.points);

  final MultiGoalGamePoint points;

  @override
  void paint(Canvas canvas, Size size) {
    // 전체화면 style
    final blackLine = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // me style
    final meFilled = Paint()
      ..color = Colors.tealAccent
      ..style = PaintingStyle.fill;

    // wall style
    final blackFilled = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // goal style
    final goalFilled = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // sinkhole style
    final greyLine = Paint()
      ..color = Colors.grey
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;


    const a = Offset(0.0, 0.0);
    final b = Offset(size.width, size.height);
    final rect = Rect.fromPoints(a, b);
    // 전체화면 draw
    canvas.drawRect(rect, blackLine);

    final me = points.me;
    final goal = points.goal;
    final wall = points.wall;
    final sinkhole = points.sinkhole;

    // 내 위치
    // 왼쪽위 (x, y)
    final pa = Offset(cellSize * me.x, cellSize * me.y);
    // 오른쪽아래 (x+1, y+1)
    final pb = Offset(cellSize * (me.x + 1), cellSize * (me.y + 1));
    canvas.drawRect(Rect.fromPoints(pa, pb), meFilled);

    // 골
    // 게임 방식이 goal list를 줄이는 방식으로 진행되는데,
    // 빨간색을 지우면 주황색이 앞 인덱스로 이동해서 빨간색이 됨
    // goal.asMap().forEach((index, g) {
    //   final ga = Offset(cellSize * g.x, cellSize * g.y);
    //   final gb = Offset(cellSize * (g.x + 1), cellSize * (g.y + 1));
    //   goalFilled.color = GoalColors[index];
    //   canvas.drawRect(Rect.fromPoints(ga, gb), goalFilled);
    // });

    goal.forEach((item) {
      final g = item.point;

      final ga = Offset(cellSize * g.x, cellSize * g.y);
      final gb = Offset(cellSize * (g.x + 1), cellSize * (g.y + 1));
      goalFilled.color = GoalColors[item.index];
      canvas.drawRect(Rect.fromPoints(ga, gb), goalFilled);
    });

    // 벽
    for (Point<int> w in wall) {
      final wa = Offset(cellSize * w.x, cellSize * w.y);
      // 오른쪽아래 (x+1, y+1)
      final wb = Offset(cellSize * (w.x + 1), cellSize * (w.y + 1));
      canvas.drawRect(Rect.fromPoints(wa, wb), blackFilled);
    }

    // 싱크홀
    for (Point<int> s in sinkhole) {
      final sa = Offset(cellSize * s.x, cellSize * s.y);
      // 오른쪽아래 (x+1, y+1)
      final sb = Offset(cellSize * (s.x + 1), cellSize * (s.y + 1));
      canvas.drawRect(Rect.fromPoints(sa, sb), greyLine);
    }
  }

  // repaint 가능 여부(true로 설정)
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
