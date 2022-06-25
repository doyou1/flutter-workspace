import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'other_page.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer? _timer;
  int _second = 10;
  bool isRunning = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_second == 0) {
        setState(() {
          timer.cancel();
          _second = 10;
          isRunning = false;
        });
      } else {
        setState(() {
          _second--;
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
          Text("TimerPage"),
          Text("$_second"),
          ElevatedButton(
            onPressed: () {
              if (!isRunning) {
                // 중복클릭 방지
                setState(() {
                  isRunning = true;
                });
                startTimer();
              }
            },
            child: Text(!isRunning ? "Start" : "Don't Click!"),
          ),
          ElevatedButton(
            onPressed: () async {
              await saveCurrentState();
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return OtherPage();
              }));
            },
            child: Text("Go to Other Page"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  Future<void> saveCurrentState() async {
    var box = await Hive.openBox("Timer");
    box.put("isRunning", isRunning);
    box.put("second", _second);
  }
}
