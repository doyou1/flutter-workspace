import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/multi_goal_joy_stick_controller.dart';

class MultiGoalJoyStickView extends StatelessWidget {
  MultiGoalJoyStickView({Key? key}) : super(key: key);

  final c = Get.find<MultiGoalJoyStickController>();

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
                onPressed: c.moveToUp,
                child: const Icon(Icons.arrow_upward),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 좌 버튼
              ElevatedButton(
                onPressed: c.moveToLeft,
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(
                width: 10.0,
              ),
              // 하 버튼
              ElevatedButton(
                onPressed: c.moveToDown,
                child: const Icon(Icons.arrow_downward),
              ),
              const SizedBox(
                width: 10.0,
              ),
              // 우 버튼
              ElevatedButton(
                onPressed: c.moveToRight,
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
