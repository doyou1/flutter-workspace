import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  bool isRunning = false;
  int _second = 10;
  Timer? _timer;

  @override
  void initState() {
    init();
    super.initState();
  }

   void init() async {
    final box = await Hive.openBox("Timer");
    isRunning = box.get("isRunning") ?? false;
    _second =  box.get("second") ?? 10;

    if(isRunning) {
      startTimer();
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_second == 0) {
        setState(() {
          timer.cancel();
          _timer = null;
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
          Text("OtherPage", style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),),
          Text(!isRunning ? "wait..." : "$_second", style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),),
          ElevatedButton(
            onPressed: () {
              if (!isRunning && _timer == null) {
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
                return Scaffold(
                  body: OtherPage(),
                );
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
