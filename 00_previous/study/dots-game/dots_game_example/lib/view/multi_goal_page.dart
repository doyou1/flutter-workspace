import 'dart:async';

import 'package:dots_game_example/model/multi_goal_game_point.dart';
import 'package:dots_game_example/util/const.dart';
import 'package:dots_game_example/util/game/game_info_painter.dart';
import 'package:dots_game_example/util/game/multi_goal_game_handler.dart';
import 'package:dots_game_example/util/hive_util.dart';
import 'package:dots_game_example/util/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../main.dart';
import '../util/game/game_point_random_generator.dart';
import '../util/game/multi_goal_game_painter.dart';

class MultiGoalPage extends StatefulWidget {
  const MultiGoalPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MultiGoalPage> createState() => _MultiGoalPageState();
}

class _MultiGoalPageState extends State<MultiGoalPage>
    with AutomaticKeepAliveClientMixin<MultiGoalPage> {
  // 게임 방법 위젯(조이스틱, 가속도계) 플래그
  bool? isSwitched;

  // 게임 좌표들 변수
  late MultiGoalGamePoint points;

  // 가속도계 이벤트 리스너 관련 변수
  StreamSubscription<AccelerometerEvent>? _streamSubscription;
  AccelerometerEvent? accelerometerEvent;
  Timer? _timer;

  MultiGoalGameHandler? handler;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    // Random Game Point 생성
    points = GamePointRandomGenerator.getMultiGoalGamePoint();
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
        if(handler != null) {
          handler!.accelerometerEvent = event;
        } else {
          accelerometerEvent = event;
        }
      });
    });

    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (isSwitched ?? false) {
        setState(() {
          step();
        });
      }
    });

    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (handler == null) {
        setState(() {
          handler = MultiGoalGameHandler(points, accelerometerEvent!);
        });
      } else {
        timer.cancel();
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: WIDGET_SIZE,
                height: WIDGET_SIZE,
                child: CustomPaint(
                  foregroundPainter: MultiGoalGamePainter(points),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomPaint(
                      foregroundPainter: GameInfoPainter(),
                      child: Container(
                        margin: EdgeInsets.only(top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Me",
                              style: TextStyle(
                                color: Colors.tealAccent,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Wall",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Sinkhole",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Goals",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
          // 게임 방법 위젯(조이스틱, 가속도계)
          !(isSwitched ?? false) ? buildJoyStick() : buildAccelerometer()
        ],
      ),
    );
  }

  // 조이스틱 위젯
  Widget buildJoyStick() {
    return Container(
      height: 150,
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
                      points = handler!.moveToUp().result();
                      checkSinkHole(handler!.isSinkHole());
                      checkGoal(handler!.isSuccess());
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
                    if (accelerometerEvent != null && handler != null) {
                      points = handler!.moveToLeft().result();
                      checkSinkHole(handler!.isSinkHole());
                      checkGoal(handler!.isSuccess());
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
                    if (accelerometerEvent != null && handler != null) {
                      points = handler!.moveToDown().result();
                      checkSinkHole(handler!.isSinkHole());
                      checkGoal(handler!.isSuccess());
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
                    if (accelerometerEvent != null && handler != null) {
                      points = handler!.moveToRight().result();
                      checkSinkHole(handler!.isSinkHole());
                      checkGoal(handler!.isSuccess());
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
      height: 150.0,
      child: Column(
        children: [
          Text(
              "x: ${accelerometerEvent?.x ?? 0.0}, y: ${accelerometerEvent?.y ?? 0.0}, z: ${accelerometerEvent?.z ?? 0.0}"),
          Text("상하좌우로 움직여보세요!"),
        ],
      ),
    );
  }

  // timer 실행시 호출되는 메서드
  void step() async {
    setState(() {
      if (accelerometerEvent != null) {
        points = handler!.step().result();
        checkSinkHole(handler!.isSinkHole());
        checkGoal(handler!.isSuccess());
      }
    });
  }

  // 현재 Goal 도착 확인 메서드
  void checkGoal(bool isGoal) async {
    if (isGoal) {
      await Future.delayed(const Duration(milliseconds: 100));
      HiveUtil.saveIsSwitched(isSwitched ?? false);

      if (!mounted) return;
      SnackBarUtil.showWinSnackBar(context);

      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return HomePage(
          index: 3,
        );
      }));
    }
  }

  void checkSinkHole(bool isSinkHole) async {
    if (isSinkHole) {
      await Future.delayed(const Duration(milliseconds: 100));
      HiveUtil.saveIsSwitched(isSwitched ?? false);

      if (!mounted) return;
      SnackBarUtil.showIsSinkHoleSnackBar(context);

      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return HomePage(
          index: 3,
        );
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

    // if (_handlerTimer != null) {
    //   _handlerTimer!.cancel();
    //   _handlerTimer = null;
    // }
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
