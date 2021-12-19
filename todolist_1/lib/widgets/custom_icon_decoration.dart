import 'package:flutter/material.dart';

class CustomIconDecoration extends Decoration {
  final double iconSize;
  final double lineWidth;
  final bool firstData;
  final bool lastData;

  const CustomIconDecoration({
    required double iconSize,
    required double lineWidth,
    required bool firstData,
    required bool lastData,
  })  : this.iconSize = iconSize,
        this.lineWidth = lineWidth,
        this.firstData = firstData,
        this.lastData = lastData;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return IconLine(
        iconSize: iconSize,
        lineWidth: lineWidth,
        firstData: firstData,
        lastData: lastData);
  }
}

class IconLine extends BoxPainter {
  final double iconSize;
  final bool firstData;
  final bool lastData;

  final Paint paintLine;

  IconLine({
    required double iconSize,
    required double lineWidth,
    required bool firstData,
    required bool lastData,
  })  : this.iconSize = iconSize,
        this.firstData = firstData,
        this.lastData = lastData,
        paintLine = Paint()
          ..color = Colors.red
          ..strokeCap = StrokeCap.round
          ..strokeWidth = lineWidth
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // TODO: implement paint
    final leftOffset = Offset((iconSize / 2) + 24, offset.dy);
    final Offset top = configuration.size!.topLeft(Offset(leftOffset.dx, 0.0));
    final Offset centerTop =
        configuration.size!.centerLeft(Offset(leftOffset.dx, leftOffset.dy));

    final Offset centerBottom =
        configuration.size!.centerLeft(Offset(leftOffset.dx, leftOffset.dy));
    final Offset end = configuration.size!
        .bottomLeft(Offset(leftOffset.dx, leftOffset.dy * 2));

    if (!firstData) canvas.drawLine(top, centerTop, paintLine);
    if (!lastData) canvas.drawLine(centerBottom, end, paintLine);
  }
}
