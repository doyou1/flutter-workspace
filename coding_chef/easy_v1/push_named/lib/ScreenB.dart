import 'package:flutter/material.dart';

class ScreenB extends StatelessWidget {
  const ScreenB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ScreenB"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text("Go to ScreenA"),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          ElevatedButton(
            child: Text("Go to ScreenC"),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/b");
            },
          ),
        ],
      )),
    );
  }
}
