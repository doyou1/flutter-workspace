import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({super.key, required this.color, this.child, });
  // final Task task;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(
                  width: 2,
                  color: color,
                )),
            child: Center(
              child: child,
            )
          );
  }
}
