import 'package:dots_game_devide_example/controller/joy_stick_controller.dart';
import 'package:dots_game_devide_example/controller/multi_goal_joy_stick_controller.dart';
import 'package:dots_game_devide_example/util/const.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/game_page/joy_stick_count_down_page.dart';
import 'package:dots_game_devide_example/view/joy_stick_sub/game_page/joy_stick_random_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/count_down_controller.dart';
import 'joy_stick_sub/game_page/joy_stick_multi_goal_page.dart';

class JoyStickPage extends StatefulWidget {
  const JoyStickPage({Key? key}) : super(key: key);

  @override
  State<JoyStickPage> createState() => _JoyStickPageState();
}

class _JoyStickPageState extends State<JoyStickPage>
    with AutomaticKeepAliveClientMixin<JoyStickPage> {
  Widget _page = JoyStickRandomPage();

  @override
  void initState() {
    super.initState();
    Get.put(JoyStickController());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) {
              changeWidget(index);
            },
            tabs: const [
              Tab(icon: Icon(Icons.looks_one), text: RANDOM_TAP_TEXT),
              Tab(icon: Icon(Icons.looks_two), text: COUNT_DOWN_TAP_TEXT),
              Tab(icon: Icon(Icons.looks_3), text: MULTI_GOAL_TAP_TEXT),
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

    setState(() {
      switch (index) {
        case 0:
          Get.put(JoyStickController());
          _page = JoyStickRandomPage();
          break;
        case 1:
          Get.put(JoyStickController());
          Get.put(CountDownController());

          _page = JoyStickCountDownPage();
          break;
        case 2:
          Get.put(MultiGoalJoyStickController());
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
