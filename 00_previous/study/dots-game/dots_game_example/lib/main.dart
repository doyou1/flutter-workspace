import 'package:dots_game_example/view/count_down_page.dart';
import 'package:dots_game_example/view/multi_goal_page.dart';
import 'package:dots_game_example/view/random_page.dart';
import 'package:dots_game_example/view/sink_hole_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main()  async {
  // Initializes Hive with the path from getApplicationDocumentsDirectory.
  // You can provide a subDir where the boxes should be stored.
  // Hive 초기화
  await Hive.initFlutter();
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
  const HomePage({this.index});
  final int? index;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: index ?? 0,
      // initialIndex: index ?? 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.looks_one), text: "Random"),
              Tab(icon: Icon(Icons.looks_two), text: "CountDown"),
              Tab(icon: Icon(Icons.looks_3), text: "SinkHole"),
              Tab(icon: Icon(Icons.looks_4), text: "MultiGoal"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RandomPage(),
            CountDownPage(),
            SinkHolePage(),
            MultiGoalPage(),
          ],
        ),
      ),
    );
  }
}