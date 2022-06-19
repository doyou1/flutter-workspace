import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:refactoring_firebase_chat/view/login_view.dart';
import 'package:refactoring_firebase_chat/view/main_view.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const SplashScreen());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Refactoring",
      home: FutureBuilder(
        future: fakeFirebaseInit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return LoginView();
            } else {
              return MainView();
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
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
