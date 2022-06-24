import 'dart:async';

import 'package:dots_game_example/util/const.dart';
import 'package:dots_game_example/util/hive_util.dart';
import 'package:dots_game_example/view/game_point.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../main.dart';
import '../util/game/game_handler.dart';
import '../util/game/game_painter.dart';
import '../util/game/game_point_random_generator.dart';

class DotsGamePage extends StatefulWidget {
  const DotsGamePage({
    Key? key,
  }) : super(key: key);

  @override
  State<DotsGamePage> createState() => _DotsGamePageState();
}

class _DotsGamePageState extends State<DotsGamePage> {
  late GamePoint points;
  bool? isSwitched;

  StreamSubscription<AccelerometerEvent>? _streamSubscription;
  AccelerometerEvent? accelerometerEvent;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    points = GamePointRandomGenerator.getGamePoint();
    setIsSwitched();
    setListener();
  }

  void setIsSwitched() async {
    isSwitched = await HiveUtil.getIsSwitched();
  }

  void setListener() {
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        accelerometerEvent = event;
      });
    });

    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (isSwitched ?? false) {
        setState(() {
          step();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 게임 위젯(픽셀 paint)
          Container(
            width: WIDGET_SIZE,
            height: WIDGET_SIZE,
            child: CustomPaint(
              foregroundPainter: GamePainter(points),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          // Switch
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
          // 게임 방법 위젯(조이스틱, 가속도계)
          !(isSwitched ?? false) ? buildJoyStick() : buildAccelerometer()
        ],
      ),
    );
  }

  Widget buildJoyStick() {
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
                    if (accelerometerEvent != null) {
                      final handler = GameHandler(points, accelerometerEvent!);
                      points = handler.moveToUp().result();
                      checkGoal(handler.isGoal());
                    }
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
                    if (accelerometerEvent != null) {
                      final handler = GameHandler(points, accelerometerEvent!);
                      points = handler.moveToLeft().result();
                      checkGoal(handler.isGoal());
                    }
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
                    if (accelerometerEvent != null) {
                      final handler = GameHandler(points, accelerometerEvent!);
                      points = handler.moveToDown().result();
                      checkGoal(handler.isGoal());
                    }
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
                    if (accelerometerEvent != null) {
                      final handler = GameHandler(points, accelerometerEvent!);
                      points = handler.moveToRight().result();
                      checkGoal(handler.isGoal());
                    }
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
    return Container(
      height: 200.0,
      child: Column(
        children: [
          Text("상하좌우로 움직여보세요!"),
        ],
      ),
    );
  }

  void step() async {
    if (accelerometerEvent != null) {
      final handler = GameHandler(points, accelerometerEvent!);
      points = handler.step().result();
      checkGoal(handler.isGoal());
    }
  }

  void checkGoal(bool isGoal) async {
    if (isGoal) {
      await Future.delayed(const Duration(milliseconds: 100));
      HiveUtil.saveIsSwitched(isSwitched ?? false);

      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    }
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

  @override
  void dispose() {
    super.dispose();
    cancleListener();
  }
}
