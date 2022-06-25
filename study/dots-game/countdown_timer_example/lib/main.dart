import 'dart:async';

import 'package:countdown_timer_example/timer_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {

  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TimerPage(),
    );
  }
}
