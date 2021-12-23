import 'package:flutter/material.dart';

class TweensPage extends StatefulWidget {
  const TweensPage({Key? key}) : super(key: key);
  static const String routeName = '/basics/tweens_page';

  @override
  _TweensPageState createState() => _TweensPageState();
}

class _TweensPageState extends State<TweensPage>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(seconds: 1);
  static const double accountBalance = 1000000;
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: _duration)
      ..addListener(() {
        // 위젯 트리를 더티로 표시합니다.
        // Marks the widget tree as dirty
        setState(() {});
      });

    animation = Tween(begin: 0.0, end: accountBalance).animate(controller);
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
        title: const Text('Tweens'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Text(
                '\$${animation.value.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            ElevatedButton(
              child: Text(
                controller.status == AnimationStatus.completed
                    ? 'Buy a Mansion'
                    : 'Win Lottery',
              ),
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
