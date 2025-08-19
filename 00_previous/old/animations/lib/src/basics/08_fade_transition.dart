import 'package:flutter/material.dart';
import 'dart:math';

class FadeTransitionPage extends StatefulWidget {
  const FadeTransitionPage({Key? key}) : super(key: key);
  static const String routeName = '/basics/fade_trasition';

  @override
  _FadeTransitionPageState createState() => _FadeTransitionPageState();
}

class _FadeTransitionPageState extends State<FadeTransitionPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;
  late CurvedAnimation _curve;

  static const curves = [
    Curves.bounceIn,
    Curves.decelerate,
    Curves.easeIn,
    Curves.slowMiddle,
    Curves.fastOutSlowIn,
    Curves.elasticIn,
    Curves.easeOut,
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade Transition'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _animation,
              child: const Icon(
                Icons.star,
                color: Colors.amber,
                size: 300,
              ),
            ),
            ElevatedButton(
              child: const Text('animate'),
              onPressed: () => setState(() {
                _controller.animateTo(1.0).then<TickerFuture>(
                    (value) => _controller.animateBack(0.0));

                var idx = Random().nextInt(curves.length - 1);
                print("idx: $idx");

                setState(() {
                  _curve =
                      CurvedAnimation(parent: _controller, curve: curves[idx]);
                  _animation = Tween(
                    begin: 1.0,
                    end: 0.0,
                  ).animate(_curve);
                });
              }),
            )
          ],
        ),
      ),
    );
  }
}
