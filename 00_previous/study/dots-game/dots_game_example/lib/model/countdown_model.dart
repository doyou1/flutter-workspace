import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import '../util/const.dart';
import 'game_point.dart';

class CountdownModel {
  // 게임 방법 위젯(조이스틱, 가속도계) 플래그
  bool? isSwitched;

// 카운트다운 타이머 관련 설정
  bool isRunning = false;
  int second = SECOND;
  int gameCount = GAME_COUNT;
  Timer? countdownTimer;

// 게임 좌표들 변수
  late GamePoint points;

// 가속도계 이벤트 리스너 관련 변수
  StreamSubscription<AccelerometerEvent>? streamSubscription;
  AccelerometerEvent? accelerometerEvent;
  Timer? accelerometerTimer;
}