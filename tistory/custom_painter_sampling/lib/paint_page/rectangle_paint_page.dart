import 'package:custom_painter_sampling/painter/rectangle_painter.dart';
import 'package:flutter/material.dart';

class RectanglePaintPage extends StatelessWidget {
  const RectanglePaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: CustomPaint(
            foregroundPainter: RectanglePainter(),
          ),
        ),
      ),
    );
  }
}