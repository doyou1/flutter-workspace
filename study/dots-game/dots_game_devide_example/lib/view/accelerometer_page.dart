import 'package:dots_game_devide_example/view/accelerometer_sub/accelerometer_count_down_page.dart';
import 'package:dots_game_devide_example/view/accelerometer_sub/accelerometer_multi_goal_page.dart';
import 'package:dots_game_devide_example/view/accelerometer_sub/accelerometer_random_page.dart';
import 'package:dots_game_devide_example/view/accelerometer_sub/accelerometer_sink_hole_page.dart';
import 'package:flutter/material.dart';

class AccelerometerPage extends StatefulWidget {
  const AccelerometerPage({Key? key}) : super(key: key);

  @override
  State<AccelerometerPage> createState() => _AccelerometerPageState();
}

class _AccelerometerPageState extends State<AccelerometerPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.looks_one), text: "one"),
              Tab(icon: Icon(Icons.looks_two), text: "two"),
              Tab(icon: Icon(Icons.looks_3), text: "three"),
              Tab(icon: Icon(Icons.looks_4), text: "four"),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              AccelerometerRandomPage(),
              AccelerometerCountDownPage(),
              AccelerometerSinkHolePage(),
              AccelerometerMultiGoalPage(),
            ],
          ),
        ),
      ),
    );
  }
}
