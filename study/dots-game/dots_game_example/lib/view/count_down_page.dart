import 'dart:async';

import 'package:dots_game_example/util/SnackbarUtil.dart';
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

class _CountDownPageState extends State<CountDownPage>
    with AutomaticKeepAliveClientMixin<CountDownPage> {
  // 게임 방법 위젯(조이스틱, 가속도계) 플래그
  bool? isSwitched;

  // 카운트다운 타이머 관련 설정
  bool isRunning = false;
  int second = SECOND;
  int gameCount = GAME_COUNT;
  Timer? _countdownTimer;

  // 게임 좌표들 변수
  late GamePoint points;

  // 가속도계 이벤트 리스너 관련 변수
  StreamSubscription<AccelerometerEvent>? _streamSubscription;
  AccelerometerEvent? accelerometerEvent;
  Timer? _accelerometerTimer;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    // Random Game Point 생성
    points = GamePointRandomGenerator.getGamePoint();
    // 직전 게임모드 불러오기
    setHiveData();
    // 가속도계 이벤트 리스너 설정
    setAccelerometerListener();
  }

  void setHiveData() async {
    isSwitched = await HiveUtil.getIsSwitched();
    isRunning = await HiveUtil.getIsRunning();
    second = await HiveUtil.getSecond();
    gameCount = await HiveUtil.getGameCount();

    if (isRunning) {
      startCountdownTimer();
    }
  }

  void setAccelerometerListener() {
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        accelerometerEvent = event;
      });
    });

    _accelerometerTimer =
        Timer.periodic(const Duration(milliseconds: MILLISECONDS), (_) {
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
                        value: isSwitched ?? false,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        }),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (!isRunning) {
                          isRunning = true;
                          startCountdownTimer();
                        }
                      });
                    },
                    child: isRunning
                        ? Text("$gameCount판남음 Countdown: $second")
                        : Text("Timer Start"),
                  ),
                ),
              ],
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
      height: 150.0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 상 버튼
              ElevatedButton(
                onPressed: () {
                  if (!isRunning) {
                    SnackbarUtil.showRequireCountdoenTimerSnackbar(context);
                    return;
                  }
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
                  if (!isRunning) {
                    SnackbarUtil.showRequireCountdoenTimerSnackbar(context);
                    return;
                  }
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
                  if (!isRunning) {
                    SnackbarUtil.showRequireCountdoenTimerSnackbar(context);
                    return;
                  }
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
                  if (!isRunning) {
                    SnackbarUtil.showRequireCountdoenTimerSnackbar(context);
                    return;
                  }
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
    if (!isRunning) {
      // showSnackbar(NOT_WORKING_COUNTDOWN_TIMER_FLAG);
      return;
    }
    if (accelerometerEvent != null) {
      final handler = GameHandler(points, accelerometerEvent!);
      points = handler.step().result();
      checkGoal(handler.isGoal());
    }
  }

  // 현재 Goal 도착 확인 메서드
  void checkGoal(bool isGoal) async {
    if (isGoal) {
      resetCountdownTimerConfigByContinue();
      if (isWinning()) {
        SnackbarUtil.showWinSnackbar(context);
        setState(() {
          cancleCountdownTimer();
          resetCountdownTimerConfig();
        });
      }
      refreshPage();
    }
  }

  void resetCountdownTimerConfig() {
    _countdownTimer = null;
    second = SECOND;
    isRunning = false;
    HiveUtil.saveIsRunning(false);
    HiveUtil.saveGameCount(GAME_COUNT);
    HiveUtil.saveSecond(SECOND);
  }

  void resetCountdownTimerConfigByContinue() {
    HiveUtil.saveIsSwitched(isSwitched ?? false);
    HiveUtil.saveIsRunning(isRunning);
    HiveUtil.saveSecond(second);
    HiveUtil.saveGameCount(gameCount - 1);
  }

  // 가속도계 이벤트 리스너 취소 메서드
  void cancleListener() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
      _streamSubscription = null;
    }

    if (_accelerometerTimer != null) {
      _accelerometerTimer!.cancel();
      _accelerometerTimer = null;
    }
  }

  void cancleCountdownTimer() {
    if (_countdownTimer != null) {
      _countdownTimer!.cancel();
      _countdownTimer = null;
    }
    resetCountdownTimerConfig();
  }

  void startCountdownTimer() {
    const oneSec = Duration(seconds: 1);
    _countdownTimer = Timer.periodic(oneSec, (timer) {
      if (second == 0) {
        setState(() {
          timer.cancel();
          resetCountdownTimerConfig();
        });
        SnackbarUtil.showFailSnackbar(context);
        refreshPage();
      } else {
        setState(() {
          second--;
        });
      }
    });
  }

  Future<void> saveCurrentTimerConfig() async {
    HiveUtil.saveIsRunning(isRunning);
    HiveUtil.saveSecond(second);
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
    return (gameCount - 1) == 0;
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
