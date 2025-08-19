import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedPositionedPage extends StatefulWidget {
  const AnimatedPositionedPage({Key? key}) : super(key: key);
  static String routeName = '/miscs/animated_positioned';

  @override
  _AnimatedPositionedPageState createState() => _AnimatedPositionedPageState();
}

class _AnimatedPositionedPageState extends State<AnimatedPositionedPage> {
  late double topPosition;
  late double leftPosition;

  double generateTopPosition(double top) => Random().nextDouble() * top;
  double generateLeftPosition(double left) => Random().nextDouble() * left;

  @override
  void initState() {
    super.initState();
    topPosition = generateTopPosition(30);
    leftPosition = generateLeftPosition(30);
  }

  void changePosition(double top, double left) {
    setState(() {
      topPosition = generateTopPosition(top);
      leftPosition = generateLeftPosition(left);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appBar = AppBar(title: const Text('AnimatedPositioned'));
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              top: topPosition,
              left: leftPosition,
              duration: const Duration(seconds: 1),
              child: InkWell(
                onTap: () => changePosition(
                    size.height -
                        (appBar.preferredSize.height + topPadding + 50),
                    size.width - 150),
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 50,
                  child: Text(
                    'Click Me',
                    style: TextStyle(
                      color:
                          Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
