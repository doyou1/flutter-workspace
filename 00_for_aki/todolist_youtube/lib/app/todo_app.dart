import 'package:flutter/material.dart';
import 'package:todolist_youtube/config/config.dart';
import 'package:todolist_youtube/screen/home_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}


// Scaffold(
//         body: Center(
//           child: Text("Hello World"),
//         )
//       )