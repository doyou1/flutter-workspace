import 'package:dots_game_example/view/dots_game_page.dart';
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
    return const Scaffold(
      body: DotsGamePage(),
    );
  }
}



