import 'package:flutter/material.dart';
import '../painter/circle_painter.dart';

class CirclePaintPage extends StatelessWidget {
  const CirclePaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: CustomPaint(
            foregroundPainter: CirclePainter(),
          ),
        ),
      ),
    );
  }
}
