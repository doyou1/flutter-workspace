import 'package:dots_game_example/main.dart';
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
  late double cellSize = (widgetSize / rows).toDouble();
  late Point<int> point =
      Point<int>((rows / 2).toInt(), (columns / 2).toInt());
  late Point<int> goal = getGoal();
  late List<Point<int>> wall = getWall();
  int wallCount = 5;

  Point<int> getGoal() {
    while(true) {
      int randomX = Random().nextInt(rows-1);
      int randomY = Random().nextInt(columns-1);

      if(point.x == randomX && point.y == randomY) {
        continue;
      } else {
        return Point<int>(randomX, randomY);
      }
    }
  }

  List<Point<int>> getWall() {
    List<Point<int>> wall = [];

    while(true) {
      if(wall.length == wallCount) return wall;
      int randomX = Random().nextInt(rows-1);
      int randomY = Random().nextInt(columns-1);

      if(point.x == randomX && point.y == randomY) {
        continue;
      }
      else if(goal.x == randomX && goal.y == randomY) {
        continue;
      } else {
        wall.add(Point<int>(randomX, randomY));
      }
    }
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
              foregroundPainter: GamePainter(point, goal, wall, rows, columns, cellSize),
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
                          checkGoal();
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
                          checkGoal();
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
                          checkGoal();
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
                          checkGoal();
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

    if(isWall(Point<int>(newX, point.y))) {
      return;
    } else {
      point = Point<int>(newX, point.y);
    }
  }

  void moveToRight() {
    int newX = point.x + 1;
    if (newX > columns - 1) newX = columns - 1;

    if(isWall(Point<int>(newX, point.y))) {
      return;
    } else {
      point = Point<int>(newX, point.y);
    }
  }

  void moveToUp() {
    int newY = point.y - 1;
    if (newY < 0) newY = 0;
    if(isWall(Point<int>(point.x, newY))) {
      return;
    } else {
      point = Point<int>(point.x, newY);
    }
  }

  void moveToDown() {
    int newY = point.y + 1;
    if (newY > rows - 1) newY = rows - 1;
    if(isWall(Point<int>(point.x, newY))) {
      return;
    } else {
      point = Point<int>(point.x, newY);
    }
  }

  void checkGoal() {
    if(point.x == goal.x && point.y == goal.y) {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    }
  }

  bool isWall(Point<int> newPoint) {

    for(Point<int> w in wall) {
      if(newPoint.x == w.x && newPoint.y == w.y) return true;
    }
    return false;
  }
}
