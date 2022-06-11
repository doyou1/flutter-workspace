import 'package:flutter/material.dart';

class RepeatingAnimationPage extends StatefulWidget {
  const RepeatingAnimationPage({Key? key}) : super(key: key);
  static String routeName = '/miscs/repeating_animation';

  @override
  _RepeatingAnimationPageState createState() => _RepeatingAnimationPageState();
}

class _RepeatingAnimationPageState extends State<RepeatingAnimationPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<BorderRadius?> _borderRadius;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);

    _borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(100.0),
      end: BorderRadius.circular(0.0),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repeating Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _borderRadius,
          builder: (context, child) {
            return Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: _borderRadius.value,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
