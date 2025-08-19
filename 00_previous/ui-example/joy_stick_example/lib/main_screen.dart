import 'package:flutter/material.dart';
import 'package:joy_stick_example/view/joy_stick_area_example.dart';
import 'package:joy_stick_example/view/joy_stick_example.dart';
import 'package:joy_stick_example/view/square_joy_stick_example.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JoyStickExample()),
                );
              },
              child: const Text("Joystick"),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JoyStickAreaExample()),
                );
              },
              child: const Text("Joystick Area"),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SquareJoyStickExample()),
                );
              },
              child: const Text("Sqaure JoyStick"),
            )
          ],
        ),
      ),
    );
  }
}
