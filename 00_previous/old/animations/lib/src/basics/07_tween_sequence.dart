import 'package:flutter/material.dart';

class TweenSequencePage extends StatefulWidget {
  const TweenSequencePage({Key? key}) : super(key: key);
  static const String routeName = '/basics/chaining_tweens_page';

  @override
  _TweenSequencePageState createState() => _TweenSequencePageState();
}

class _TweenSequencePageState extends State<TweenSequencePage>
    with SingleTickerProviderStateMixin {
  static const Duration duration = Duration(seconds: 7);
  late final AnimationController controller;
  late final Animation<Color?> animation;

  static final colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  void initState() {
    super.initState();

    final sequenceItems = <TweenSequenceItem<Color?>>[];

    for (var i = 0; i < colors.length; i++) {
      final beginColor = colors[i];
      final endColor = colors[(i + 1) % colors.length];
      final weight = 1 / colors.length;

      print('$i, ${(i + 1) % colors.length}');

      sequenceItems.add(
        TweenSequenceItem<Color?>(
          tween: ColorTween(begin: beginColor, end: endColor),
          weight: weight,
        ),
      );
    }

    controller = AnimationController(vsync: this, duration: duration);
    animation = TweenSequence<Color?>(sequenceItems).animate(controller);
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
        title: const Text('Tween Sequences'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return MaterialButton(
              color: animation.value,
              onPressed: () async {
                await controller.forward();
                controller.reset();
              },
              child: child,
            );
          },
          child: const Text(
            'Animate',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
