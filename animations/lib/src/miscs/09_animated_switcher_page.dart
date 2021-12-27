import 'dart:math';
import 'package:flutter/material.dart';

Color generateColor() => Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));

Widget generateContainer(int keyCount) => Container(
      key: ValueKey<int>(keyCount),
      height: Random().nextDouble() * 200,
      width: Random().nextDouble() * 200,
      decoration: BoxDecoration(
        color: generateColor(),
        borderRadius: BorderRadius.circular(Random().nextDouble() * 100),
        border: Border.all(
          color: generateColor(),
          width: Random().nextDouble() * 5,
        ),
      ),
    );

class AnimatedSwitcherPage extends StatefulWidget {
  const AnimatedSwitcherPage({Key? key}) : super(key: key);
  static String routeName = '/miscs/animated_switcher_page';

  @override
  _AnimatedSwitcherPageState createState() => _AnimatedSwitcherPageState();
}

class _AnimatedSwitcherPageState extends State<AnimatedSwitcherPage> {
  late Widget container;
  late int keyCount;

  @override
  void initState() {
    super.initState();
    keyCount = 0;
    container = generateContainer(keyCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedSwitcher'),
        actions: [
          MaterialButton(
            onPressed: () => setState(
              () => container = generateContainer(++keyCount),
            ),
            child: Text(
              'Change Widget',
              style: TextStyle(
                  color: Theme.of(context).buttonTheme.colorScheme!.onPrimary),
            ),
          )
        ],
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: container,
          transitionBuilder: (child, animation) => ScaleTransition(
            child: child,
            scale: animation,
          ),
        ),
      ),
    );
  }
}
