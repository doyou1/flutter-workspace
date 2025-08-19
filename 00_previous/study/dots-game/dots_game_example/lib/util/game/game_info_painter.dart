import 'package:flutter/material.dart';

import '../const.dart';

class GameInfoPainter extends CustomPainter {
  late double cellSize = (WIDGET_SIZE / ROWS).toDouble();

  @override
  void paint(Canvas canvas, Size size) {
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

    final pa = Offset(cellSize * 0, cellSize * 0);
    final pb = Offset(cellSize * (0+1), cellSize * (0+1));
    canvas.drawRect(Rect.fromPoints(pa, pb), meFilled);

    final wa = Offset(cellSize * 2, cellSize * 0);
    final wb = Offset(cellSize * (2+1), cellSize * (0+1));
    canvas.drawRect(Rect.fromPoints(wa, wb), blackFilled);


    final sa = Offset(cellSize * 4, cellSize * 0);
    final sb = Offset(cellSize * (4+1), cellSize * (0+1));
    canvas.drawRect(Rect.fromPoints(sa, sb), greyLine);


    for(int i=0; i<GOAL_COUNT; i++) {
      final ga = Offset(cellSize * (6 + (i)), cellSize * 0);
      final gb = Offset(cellSize * (6+1 + (i)), cellSize * (0+1));
      goalFilled.color = GoalColors[i];
      canvas.drawRect(Rect.fromPoints(ga, gb), goalFilled);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}