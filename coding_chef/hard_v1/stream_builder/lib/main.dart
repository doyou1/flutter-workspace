import 'dart:developer';
import 'counter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stream Builder",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Counter(),
    );
  }
}
