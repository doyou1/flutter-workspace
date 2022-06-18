import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void main() {
  var path = Directory.current.path;
  Hive.init(path);
  runApp(const SplashApp());
}

class SplashApp extends StatelessWidget {
  const SplashApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fakeFirebaseInit(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          String data = snapshot.data as String;
          return MaterialApp(
            title: "Refactoring",
            home: Center(
              child: Text("data: $data"),
            ),
          );
        }

        return MaterialApp(
          home: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Future<String> fakeFirebaseInit() async {
  var isLogin = await Hive.openBox("currentUser");
  print("isLogin: $isLogin")                                      ;
  var user = await isLogin.get("user");

  print("user: ${user.toString()}");                                          
  await Future.delayed(Duration(seconds: 3), () {});
  return "done";
}

