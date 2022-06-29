import 'package:dots_game_devide_example/controller/multi_goal_accelerometer_controller.dart';
import 'package:dots_game_devide_example/view/accelerometer_sub/accelerometer_count_down_page.dart';
import 'package:dots_game_devide_example/view/accelerometer_sub/accelerometer_multi_goal_page.dart';
import 'package:dots_game_devide_example/view/accelerometer_sub/accelerometer_random_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/accelerometer_controller.dart';
import '../controller/count_down_controller.dart';
import '../util/const.dart';

class AccelerometerPage extends StatefulWidget {
  const AccelerometerPage({Key? key}) : super(key: key);

  @override
  State<AccelerometerPage> createState() => _AccelerometerPageState();
}

class _AccelerometerPageState extends State<AccelerometerPage> {
  Widget _page = AccelerometerRandomPage();

  @override
  void initState() {
    super.initState();
    Get.put(AccelerometerController());
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
          Get.put(AccelerometerController());
          _page = AccelerometerRandomPage();
          break;
        case 1:
          Get.put(AccelerometerController());
          Get.put(CountDownController());
          _page = AccelerometerCountDownPage();
          break;
        case 2:
          Get.put(MultiGoalAccelerometerController());
          _page = AccelerometerMultiGoalPage();
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
