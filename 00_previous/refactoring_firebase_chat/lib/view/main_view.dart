import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _authentication = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("1234"),
              ElevatedButton(
                onPressed: () {
                  _authentication.signOut();
                },
                child: Text("logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
