import 'package:flutter/material.dart';
import 'package:joy_stick_example/util/const.dart';

class Ball extends StatelessWidget {
  final double x;
  final double y;

  const Ball(this.x, this.y, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(left: x, top: y, child: Container(
      width: ballSize,
      height: ballSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ]
      ),
    ));
  }
}
