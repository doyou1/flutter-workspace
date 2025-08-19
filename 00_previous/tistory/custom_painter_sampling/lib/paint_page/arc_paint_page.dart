import 'package:flutter/material.dart';
import '../painter/arc_painter.dart';

class ArcPaintPage extends StatelessWidget {
  const ArcPaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: CustomPaint(
            foregroundPainter: ArcPainter(),
          ),
        ),
      ),
    );
  }
}
