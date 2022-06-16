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
    return FutureBuilder(
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
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: "Firebase Chat",
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return ChatView();
                } else {
                  return LoginSignUpView();
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