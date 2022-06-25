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

class CountDownPage extends StatefulWidget {
  const CountDownPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CountDownPage> createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage> with AutomaticKeepAliveClientMixin<CountDownPage> {
  // 게임 방법 위젯(조이스틱, 가속도계) 플래그
  bool? isSwitched;

  // 게임 좌표들 변수
  late GamePoint points;

  // 가속도계 이벤트 리스너 관련 변수
  StreamSubscription<AccelerometerEvent>? _streamSubscription;
  AccelerometerEvent? accelerometerEvent;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    // Random Game Point 생성
    points = GamePointRandomGenerator.getGamePoint();
    // 직전 게임모드 불러오기
    setIsSwitched();
    // 가속도계 이벤트 리스너 설정
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
          // 게임 화면 위젯(픽셀 paint)
          Container(
            width: WIDGET_SIZE,
            height: WIDGET_SIZE,
            child: CustomPaint(
              foregroundPainter: GamePainter(points),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),

          // 스위치 위젯
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
          const SizedBox(
            height: 30.0,
          ),

          // 게임 방법 위젯(조이스틱, 가속도계)
          !(isSwitched ?? false) ? buildJoyStick() : buildAccelerometer()
        ],
      ),
    );
  }

  // 조이스틱 위젯
  Widget buildJoyStick() {
    return Container(
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 상 버튼
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
                child: const Icon(Icons.arrow_upward),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 좌 버튼
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
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(
                width: 10.0,
              ),
              // 하 버튼
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
                child: const Icon(Icons.arrow_downward),
              ),
              const SizedBox(
                width: 10.0,
              ),
              // 우 버튼
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
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 가속도계 위젯
  Widget buildAccelerometer() {
    return Container(
      height: 200.0,
      child: Column(
        children: [
          Text("x: ${accelerometerEvent?.x ?? 0.0}, y: ${accelerometerEvent?.y ?? 0.0}, z: ${accelerometerEvent?.z ?? 0.0}"),
          Text("상하좌우로 움직여보세요!"),
        ],
      ),
    );
  }

  // timer 실행시 호출되는 메서드
  void step() async {
    if (accelerometerEvent != null) {
      final handler = GameHandler(points, accelerometerEvent!);
      points = handler.step().result();
      checkGoal(handler.isGoal());
    }
  }

  // 현재 Goal 도착 확인 메서드
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

  // 가속도계 이벤트 리스너 취소 메서드
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

  // Tabbar 변경에 따라 to block reload
  @override
  bool get wantKeepAlive => true;

}
