import 'package:flutter/material.dart';
import 'package:stateful_lifecycle/ScreenC.dart';

import 'ScreenB.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ScreenA"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => const ScreenB()
                ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
              ),
              child: const Text(
                "Go to ScreenB",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) => const ScreenC()
                ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
              ),
              child: const Text(
                "Go to ScreenC",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
