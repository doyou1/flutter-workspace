import 'package:flutter/material.dart';
import 'dart:math';

import '../util/game_painter.dart';

class DotsGamePage extends StatefulWidget {
  const DotsGamePage({Key? key}) : super(key: key);

  @override
  State<DotsGamePage> createState() => _DotsGamePageState();
}

class _DotsGamePageState extends State<DotsGamePage> {
  double widgetSize = 300.0;
  int rows = 10;
  int columns = 10;
  late Point<int> point =
      Point<int>((rows / 2).toInt(), (columns / 2).toInt());
  late double cellSize = (widgetSize / rows).toDouble();

  // late Timer _timer;
  // final int milliseconds = 200;

  @override
  void initState() {
    super.initState();

    // 0.2초마다 reprint
    // _timer = Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
    //   _step();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: widgetSize,
            height: widgetSize,
            child: CustomPaint(
              foregroundPainter: GamePainter(point, rows, columns, cellSize),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          // 방향키 버튼
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          moveToUp();
                        });
                      },
                      child: Icon(Icons.arrow_upward),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          moveToLeft();
                        });
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          moveToDown();
                        });
                      },
                      child: Icon(Icons.arrow_downward),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          moveToRight();
                        });
                      },
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void moveToLeft() {
    int newX = point.x - 1;
    if (newX < 0) newX = 0;
    point = Point<int>(newX, point.y);
  }

  void moveToRight() {
    int newX = point.x + 1;
    if (newX > columns - 1) newX = columns - 1;
    point = Point<int>(newX, point.y);
  }

  void moveToUp() {
    int newY = point.y - 1;
    if (newY < 0) newY = 0;
    point = Point<int>(point.x, newY);
  }

  void moveToDown() {
    int newY = point.y + 1;
    if (newY > rows - 1) newY = rows - 1;
    point = Point<int>(point.x, newY);
  }
}
