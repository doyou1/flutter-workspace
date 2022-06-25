import 'package:dots_game_example/view/count_down_page.dart';
import 'package:dots_game_example/view/random_page.dart';
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
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dots Game Example"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.looks_one), text: "Random"),
              Tab(icon: Icon(Icons.looks_two), text: "CountDown"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RandomPage(),
            CountDownPage(),
          ],
        ),
      ),
    );
  }
}



