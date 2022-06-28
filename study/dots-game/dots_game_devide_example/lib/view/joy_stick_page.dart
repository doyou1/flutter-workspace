import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick_count_down_page.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick_multi_goal_page.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick_random_page.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick_sink_hole_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoyStickPage extends StatefulWidget {
  const JoyStickPage({Key? key}) : super(key: key);

  @override
  State<JoyStickPage> createState() => _JoyStickPageState();
}

class _JoyStickPageState extends State<JoyStickPage> with AutomaticKeepAliveClientMixin<JoyStickPage> {

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
              JoyStickRandomPage(),
              JoyStickCountDownPage(),
              JoyStickSinkHolePage(),
              JoyStickMultiGoalPage(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
