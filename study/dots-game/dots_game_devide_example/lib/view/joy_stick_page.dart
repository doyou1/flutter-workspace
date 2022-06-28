import 'package:dots_game_devide_example/controller/joy_stick_controller.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick_count_down_page.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick_multi_goal_page.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick_random_page.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/joy_stick_sink_hole_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/count_down_controller.dart';

class JoyStickPage extends StatefulWidget {
  const JoyStickPage({Key? key}) : super(key: key);

  @override
  State<JoyStickPage> createState() => _JoyStickPageState();
}

class _JoyStickPageState extends State<JoyStickPage>
    with AutomaticKeepAliveClientMixin<JoyStickPage> {
  Widget _page = JoyStickRandomPage();

  @override
  Widget build(BuildContext context) {
    Get.put(JoyStickController());

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) {
              changeWidget(index);
            },
            tabs: [
              Tab(icon: Icon(Icons.looks_one), text: "one"),
              Tab(icon: Icon(Icons.looks_two), text: "two"),
              Tab(icon: Icon(Icons.looks_3), text: "three"),
              Tab(icon: Icon(Icons.looks_4), text: "four"),
            ],
          ),
        ),
        body: SafeArea(
          child: _page,
        ),
      ),
    );
  }

  void changeWidget(int index) async {
    await Get.deleteAll();
    Get.put(JoyStickController());

    setState(() {
      switch (index) {
        case 0:
          _page = JoyStickRandomPage();
          break;
        case 1:
          Get.put(CountDownController());
          _page = JoyStickCountDownPage();
          break;
        case 2:
          _page = JoyStickSinkHolePage();
          break;
        case 3:
          _page = JoyStickMultiGoalPage();
          break;
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() async {
    super.dispose();
    await Get.deleteAll();
  }
}
