import 'dart:async';
import 'dart:io';

import 'package:dots_game_example/main.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'package:hive/hive.dart';

import '../util/game_painter.dart';

class DotsGamePage extends StatefulWidget {
  const DotsGamePage({Key? key,}) : super(key: key);

  @override
  State<DotsGamePage> createState() => _DotsGamePageState();
}

class _DotsGamePageState extends State<DotsGamePage> {
  double widgetSize = 300.0;

  int rows = 10;
  int columns = 10;
  late double cellSize = (widgetSize / rows).toDouble();
  late Point<int> point = Point<int>(rows ~/ 2, columns ~/ 2);
  late Point<int> goal = getGoal();
  late List<Point<int>> wall = getWall();
  int wallCount = 5;

  bool? isSwitched;

  StreamSubscription<AccelerometerEvent>? _streamSubscription;
  AccelerometerEvent? accelerometerEvent;
  List<double>? _accelerometerValues;
  Timer? _timer;

  String place = "로딩중";

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
              foregroundPainter:
                  GamePainter(point, goal, wall, rows, columns, cellSize),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            width: 100.0,
            height: 100.0,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Switch(
                  value: isSwitched ?? false,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  }),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          // 방향키 버튼
          !(isSwitched ?? false) ? buildJoyStick() : buildAccelerometer()
        ],
      ),
    );
  }

  Widget buildJoyStick() {
    // print("joystick");
    // cancleListener();
    return Container(
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    moveToUp();
                    _isGoal();
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
                    _isGoal();
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
                    _isGoal();
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
                    _isGoal();
                  });
                },
                child: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAccelerometer() {
    // print("Accelerometer");
    return Container(
      height: 200.0,
      child: Column(
        children: [
          Text("_accelerometerValues: $_accelerometerValues"),
          Text("상하좌우: $place"),
        ],
      ),
    );
  }

  void _checkAction() {
    // 상 : x가 음수
    // 하 : x가 양수
    var topBottom = "중";
    if (accelerometerEvent!.x < -1.0) {
      moveToUp();
      topBottom = "상";
    } else if (-1.0 < accelerometerEvent!.x && accelerometerEvent!.x < 1.0) {
      topBottom = "중";
    } else if (1.0 < accelerometerEvent!.x) {
      moveToDown();
      topBottom = "하";
    }

    // 좌 : y가 음수
    // 우 : y가 양수
    var leftRight = "중";
    if (accelerometerEvent!.y < -1.0) {
      moveToLeft();
      leftRight = "좌";
    } else if (-1.0 < accelerometerEvent!.y && accelerometerEvent!.y < 1.0) {
      leftRight = "중";
    } else if (1.0 < accelerometerEvent!.y) {
      moveToRight();
      leftRight = "우";
    }
    _accelerometerValues = <double>[
      accelerometerEvent!.x,
      accelerometerEvent!.y,
      accelerometerEvent!.z
    ];
    place = "$topBottom $leftRight";
  }

  void setListener() {
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        accelerometerEvent = event;
        // _accelerometerValues = <double>[event.x, event.y, event.z];
        // _checkAction();
      });
    });

    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (isSwitched ?? false) {
        setState(() {
          _checkAction();
          _isGoal();
        });
      }
    });
  }

  void cancleListener() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
      _streamSubscription = null;
    }

    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void moveToLeft() {
    int newX = point.x - 1;
    if (newX < 0) newX = 0;

    if (isWall(Point<int>(newX, point.y))) {
      return;
    } else {
      point = Point<int>(newX, point.y);
    }
  }

  void moveToRight() {
    int newX = point.x + 1;
    if (newX > columns - 1) newX = columns - 1;

    if (isWall(Point<int>(newX, point.y))) {
      return;
    } else {
      point = Point<int>(newX, point.y);
    }
  }

  void moveToUp() {
    int newY = point.y - 1;
    if (newY < 0) newY = 0;
    if (isWall(Point<int>(point.x, newY))) {
      return;
    } else {
      point = Point<int>(point.x, newY);
    }
  }

  void moveToDown() {
    int newY = point.y + 1;
    if (newY > rows - 1) newY = rows - 1;
    if (isWall(Point<int>(point.x, newY))) {
      return;
    } else {
      point = Point<int>(point.x, newY);
    }
  }

  void _isGoal() {
    if (point.x == goal.x && point.y == goal.y) {
      saveIsSwitched();
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    }
  }

  bool isWall(Point<int> newPoint) {
    for (Point<int> w in wall) {
      if (newPoint.x == w.x && newPoint.y == w.y) return true;
    }
    return false;
  }

  Point<int> getGoal() {
    while (true) {
      int randomX = Random().nextInt(rows - 1);
      int randomY = Random().nextInt(columns - 1);

      if (point.x == randomX && point.y == randomY) {
        continue;
      } else {
        return Point<int>(randomX, randomY);
      }
    }
  }

  List<Point<int>> getWall() {
    List<Point<int>> wall = [];

    while (true) {
      if (wall.length == wallCount) return wall;
      int randomX = Random().nextInt(rows - 1);
      int randomY = Random().nextInt(columns - 1);

      if (point.x == randomX && point.y == randomY) {
        continue;
      } else if (goal.x == randomX && goal.y == randomY) {
        continue;
      } else {
        wall.add(Point<int>(randomX, randomY));
      }
    }
  }

  void saveIsSwitched() async {
    var path = Directory.current.path;
    Hive
      .init(path);
    var box = await Hive.openBox("Session");
    box.put("isSwitched", isSwitched);
  }

  void setIsSwitched() async {
    isSwitched =  await getIsSwitched();
  }


  Future<bool> getIsSwitched() async {
    var box = await Hive.openBox("Session");
    return box.get("isSwitched") ?? false;
  }

  @override
  void initState() {
    super.initState();
    setIsSwitched();
    setListener();
  }



  @override
  void dispose() {
    super.dispose();
    cancleListener();
  }
}
