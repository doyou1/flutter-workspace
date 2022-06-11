import 'package:flutter/material.dart';
import 'dart:math';

Color generateColor() => Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));

class AnimatedBuilderPage extends StatefulWidget {
  const AnimatedBuilderPage({Key? key}) : super(key: key);
  static const String routeName = '/basics/animated_builder_page';

  @override
  _AnimatedBuilderPageState createState() => _AnimatedBuilderPageState();
}

class _AnimatedBuilderPageState extends State<AnimatedBuilderPage>
    with SingleTickerProviderStateMixin {
  late Color beginColor = Colors.deepPurple;
  late Color endColor = Colors.deepOrange;
  Duration duration = const Duration(milliseconds: 1500);
  late AnimationController controller;
  late Animation<Color?> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: duration);
    animation =
        ColorTween(begin: beginColor, end: endColor).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedBuilder'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return MaterialButton(
              color: animation.value,
              height: 50,
              minWidth: 100,
              child: child,
              onPressed: () {
                if (controller.status == AnimationStatus.completed) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
                print(beginColor);
                print(endColor);
                beginColor = endColor;
                endColor = generateColor();

                animation = ColorTween(begin: beginColor, end: endColor)
                    .animate(controller);
              },
            );
          },
          child: const Text(
            'Change Color',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
