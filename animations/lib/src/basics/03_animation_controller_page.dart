import 'package:flutter/material.dart';

class AnimationControllerPage extends StatefulWidget {
  const AnimationControllerPage({Key? key}) : super(key: key);
  static const String routeName = '/basics/animation_controller_page';

  @override
  _AnimationControllerPageState createState() =>
      _AnimationControllerPageState();
}

class _AnimationControllerPageState extends State<AnimationControllerPage>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(seconds: 1);
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: _duration)
      ..addListener(() {
        setState(() {});
      });
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
        title: const Text('Animation Controller'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Text(
                controller.value.toStringAsFixed(2),
                style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1 + controller.value,
              ),
            ),
            ElevatedButton(
              child: const Text('animate'),
              onPressed: () {
                if (controller.status == AnimationStatus.completed) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
