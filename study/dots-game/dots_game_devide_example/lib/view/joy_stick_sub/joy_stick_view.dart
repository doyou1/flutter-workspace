import 'package:dots_game_devide_example/controller/joy_stick_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoyStickView extends StatelessWidget {
  JoyStickView({this.isRunning = true, Key? key}) : super(key: key);

  final c = Get.find<JoyStickController>();

  bool isRunning;

  @override
  Widget build(BuildContext context) {
    c.context = context;

    return Container(
      height: 150,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 상 버튼
              ElevatedButton(
                onPressed: isRunning ? c.moveToUp : null,
                child: const Icon(Icons.arrow_upward),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 좌 버튼
              ElevatedButton(
                onPressed: isRunning ? c.moveToLeft : null,
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(
                width: 10.0,
              ),
              // 하 버튼
              ElevatedButton(
                onPressed: isRunning ? c.moveToDown : null,
                child: const Icon(Icons.arrow_downward),
              ),
              const SizedBox(
                width: 10.0,
              ),
              // 우 버튼
              ElevatedButton(
                onPressed: isRunning ? c.moveToRight : null,
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
