import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AccelerometerPage(),
    );
  }
}

class AccelerometerPage extends StatefulWidget {
  const AccelerometerPage({Key? key}) : super(key: key);

  @override
  State<AccelerometerPage> createState() => _AccelerometerPageState();
}

class _AccelerometerPageState extends State<AccelerometerPage> {
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  AccelerometerEvent? accelerometerEvent;
  List<double>? _accelerometerValues;
  String place = "로딩";

  @override
  void initState() {
    super.initState();
    // 가속도계 정보 취득 리스너unning Gradle task 'assembleDebug'...
    // √  Built build\app\outputs\flutter-apk\app-debug.apk.
    // F/crash_dump64(17766): crash_dump.cpp:482] failed to attach to thread 183: Permission denied
    // F/crash_dump64(17775): crash_dump.cpp:482] failed to attach to thread 190: Permission denied
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        accelerometerEvent = event;
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
      _checkAction();
    });
  }

  void _checkAction() {


    // 상 : x가 음수
    // 하 : x가 양수
    var topBottom = "중";
    if(accelerometerEvent!.x < -1.0) {
      topBottom = "상";
    } else if(-1.0 < accelerometerEvent!.x && accelerometerEvent!.x < 1.0) {
      topBottom = "중";
    } else if(1.0 < accelerometerEvent!.x) {
      topBottom = "하";
    }

    // 좌 : y가 음수
    // 우 : y가 양수
    var leftRight = "중";
    if(accelerometerEvent!.y < -1.0) {
      leftRight = "좌";
    } else if(-1.0 < accelerometerEvent!.y && accelerometerEvent!.y < 1.0) {
      leftRight = "중";
    } else if(1.0 < accelerometerEvent!.y) {
      leftRight = "우";
    }
    place = "$topBottom $leftRight";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("_accelerometerValues: $_accelerometerValues"),
            Text("상하좌우: $place"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }
}
