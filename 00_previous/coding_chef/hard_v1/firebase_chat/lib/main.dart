import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/views/chat.dart';
import 'package:firebase_chat/views/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Creates a widget that builds itself based on the latest snapshot of interaction with a Future.
    // The builder must not be null.
    // Future와의 상호 작용에 대한 최신 스냅샷을 기반으로 자체적으로 빌드되는 위젯을 만듭니다.
    // 빌더는 null이 아니어야 합니다.
    return FutureBuilder(
      // Initializes a new FirebaseApp instance by name and options and returns the created app.
      // This method should be called before any usage of FlutterFire plugins
      // FlutterFire를 사용하기 전에 호출해야 합니다.
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Center(
              child: Text("app has error"),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) { // 1. firebase auth와 연결이 됐다면
          return MaterialApp(
            title: "Firebase Chat",
            // Creates a new StreamBuilder that builds itself based on the latest snapshot of interaction with the specified stream and whose build strategy is given by builder.
            // The initialData is used to create the initial snapshot.
            // The builder must not be null.
            // 지정된 스트림과의 상호 작용에 대한 최신 스냅샷을 기반으로 자체적으로 빌드되고 해당 빌드 전략이 빌더에서 제공되는 새 StreamBuilder를 만듭니다.
            // initialData는 초기 스냅샷을 만드는 데 사용됩니다.
            // 빌더는 null이 아니어야 합니다.
            home: StreamBuilder(
              // Notifies about changes to the user's sign-in state (such as sign-in or sign-out)
              // 유저의 로그인, 로그아웃 등 변화를 알아챕니다.
              // 아마 확인해서 로그인 하고
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                print("snapshot: ${snapshot.data.toString()}");
                if(snapshot.hasData) {  // 로그인을 기존에 했다면
                  return ChatView();  // 채팅화면, 메인화면
                } else {              // 로그아웃 혹은 로그인이 돼있지않다면
                  return LoginSignUpView();  // 로그인 및 회원가입 화면
                }
              },
            ),
          );
        }
        return const MaterialApp(
          home: Center(
            child: SpinKitDoubleBounce(
              color: Colors.white,
              size: 80.0,
            ),
          ),
        );
      },
    );
  }
}
