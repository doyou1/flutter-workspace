import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:refactoring_firebase_chat/screen/login_screen.dart';
import 'package:refactoring_firebase_chat/screen/main_screen.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const SplashScreen());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Refactoring",
      home: Scaffold(
        body: FutureBuilder(
          future: fakeFirebaseInit(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return LoginScreen();
              } else {
                return MainScreen();
              }
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

Future<dynamic> fakeFirebaseInit() async {
  var box = await Hive.openBox("currentUser");
  var user = await box.get("user");

  // await Future.delayed(Duration(seconds: 3), () {});
  return user;
  // return "not null";
}
