import 'dart:async';

import 'package:dots_game_example/model/countdown_model.dart';
import 'package:dots_game_example/util/const.dart';
import 'package:dots_game_example/util/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../main.dart';
import '../util/game/game_handler.dart';
import '../util/game/game_painter.dart';
import '../util/game/game_point_random_generator.dart';
import '../util/snack_bar_util.dart';

class CountDownPage extends StatefulWidget {
  const CountDownPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CountDownPage> createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage>
    with AutomaticKeepAliveClientMixin<CountDownPage> {

  late CountdownModel _model;


  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _model = CountdownModel();
    // Random Game Point 생성
    _model.points = GamePointRandomGenerator.getGamePoint();
    // 직전 게임모드 불러오기
    setHiveData();
    // 가속도계 이벤트 리스너 설정
    setAccelerometerListener();
  }

  void setHiveData() async {
    _model.isSwitched = await HiveUtil.getIsSwitched();
    _model.isRunning = await HiveUtil.getIsRunning();
    _model.second = await HiveUtil.getSecond();
    _model.gameCount = await HiveUtil.getGameCount();

    if (_model.isRunning) {
      startCountdownTimer();
    }
  }

  void setAccelerometerListener() {
    _model.streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        _model.accelerometerEvent = event;
      });
    });

    _model.accelerometerTimer =
        Timer.periodic(const Duration(milliseconds: MILLISECONDS), (_) {
      if (_model.isSwitched ?? false) {
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
              foregroundPainter: GamePainter(_model.points),
            ),
          ),
          // 스위치 위젯
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Switch(
                        value: _model.isSwitched ?? false,
                        onChanged: (value) {
                          setState(() {
                            _model.isSwitched = value;
                          });
                        }),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (!_model.isRunning) {
                          _model.isRunning = true;
                          startCountdownTimer();
                        }
                      });
                    },
                    child: _model.isRunning
                        ? Text("${_model.gameCount}판남음 Countdown: ${_model.second}")
                        : Text("Timer Start"),
                  ),
                ),
              ],
            ),
          ),
          // 게임 방법 위젯(조이스틱, 가속도계)
          !(_model.isSwitched ?? false) ? buildJoyStick() : buildAccelerometer()
        ],
      ),
    );
  }

  // 조이스틱 위젯
  Widget buildJoyStick() {
    return Container(
      height: 150.0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 상 버튼
              ElevatedButton(
                onPressed: () {
                  if (!_model.isRunning) {
                    SnackBarUtil.showRequireCountdoenTimerSnackBar(context);
                    return;
                  }
                  setState(() {
                    if (_model.accelerometerEvent != null) {
                      final handler = GameHandler(_model.points, _model.accelerometerEvent!);
                      _model.points = handler.moveToUp().result();
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
                  if (!_model.isRunning) {
                    SnackBarUtil.showRequireCountdoenTimerSnackBar(context);
                    return;
                  }
                  setState(() {
                    if (_model.accelerometerEvent != null) {
                      final handler = GameHandler(_model.points, _model.accelerometerEvent!);
                      _model.points = handler.moveToLeft().result();
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
                  if (!_model.isRunning) {
                    SnackBarUtil.showRequireCountdoenTimerSnackBar(context);
                    return;
                  }
                  setState(() {
                    if (_model.accelerometerEvent != null) {
                      final handler = GameHandler(_model.points, _model.accelerometerEvent!);
                      _model.points = handler.moveToDown().result();
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
                  if (!_model.isRunning) {
                    SnackBarUtil.showRequireCountdoenTimerSnackBar(context);
                    return;
                  }
                  setState(() {
                    if (_model.accelerometerEvent != null) {
                      final handler = GameHandler(_model.points, _model.accelerometerEvent!);
                      _model.points = handler.moveToRight().result();
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
      height: 150.0,
      child: Column(
        children: [
          Text(
              "x: ${_model.accelerometerEvent?.x ?? 0.0}, y: ${_model.accelerometerEvent?.y ?? 0.0}, z: ${_model.accelerometerEvent?.z ?? 0.0}"),
          Text("상하좌우로 움직여보세요!"),
        ],
      ),
    );
  }

  // timer 실행시 호출되는 메서드
  void step() async {
    if (!_model.isRunning) {
      // showSnackBar(NOT_WORKING_COUNTDOWN_TIMER_FLAG);
      return;
    }
    if (_model.accelerometerEvent != null) {
      final handler = GameHandler(_model.points, _model.accelerometerEvent!);
      _model.points = handler.step().result();
      checkGoal(handler.isGoal());
    }
  }

  // 현재 Goal 도착 확인 메서드
  void checkGoal(bool isGoal) async {
    if (isGoal) {
      resetCountdownTimerConfigByContinue();
      if (isWinning()) {
        SnackBarUtil.showWinSnackBar(context);
        setState(() {
          cancleCountdownTimer();
          resetCountdownTimerConfig();
        });
      }
      refreshPage();
    }
  }

  void resetCountdownTimerConfig() {
    _model.countdownTimer = null;
    _model.second = SECOND;
    _model.isRunning = false;
    HiveUtil.saveIsRunning(false);
    HiveUtil.saveGameCount(GAME_COUNT);
    HiveUtil.saveSecond(SECOND);
  }

  void resetCountdownTimerConfigByContinue() {
    HiveUtil.saveIsSwitched(_model.isSwitched ?? false);
    HiveUtil.saveIsRunning(_model.isRunning);
    HiveUtil.saveSecond(_model.second);
    HiveUtil.saveGameCount(_model.gameCount - 1);
  }

  // 가속도계 이벤트 리스너 취소 메서드
  void cancleListener() {
    if (_model.streamSubscription != null) {
      _model.streamSubscription!.cancel();
      _model.streamSubscription = null;
    }

    if (_model.accelerometerTimer != null) {
      _model.accelerometerTimer!.cancel();
      _model.accelerometerTimer = null;
    }
  }

  void cancleCountdownTimer() {
    if (_model.countdownTimer != null) {
      _model.countdownTimer!.cancel();
      _model.countdownTimer = null;
    }
    resetCountdownTimerConfig();
  }

  void startCountdownTimer() {
    const oneSec = Duration(seconds: 1);
    _model.countdownTimer = Timer.periodic(oneSec, (timer) {
      if (_model.second == 0) {
        setState(() {
          timer.cancel();
          resetCountdownTimerConfig();
        });
        SnackBarUtil.showFailSnackBar(context);
        refreshPage();
      } else {
        setState(() {
          _model.second--;
        });
      }
    });
  }

  Future<void> saveCurrentTimerConfig() async {
    HiveUtil.saveIsRunning(_model.isRunning);
    HiveUtil.saveSecond(_model.second);
  }

  @override
  void dispose() {
    super.dispose();
    cancleListener();
    cancleCountdownTimer();
  }

  // Tabbar 변경에 따라 to block reload
  @override
  bool get wantKeepAlive => true;

  bool isWinning() {
    return (_model.gameCount - 1) == 0;
  }

  void refreshPage() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomePage(
        index: 1,
      );
    }));
  }
}
