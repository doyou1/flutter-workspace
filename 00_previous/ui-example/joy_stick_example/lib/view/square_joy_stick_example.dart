import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:joy_stick_example/util/const.dart';
import 'package:joy_stick_example/view/sub_view/ball.dart';
import 'package:joy_stick_example/view/sub_view/joy_stick_mode_dropdown.dart';

class SquareJoyStickExample extends StatefulWidget {
  const SquareJoyStickExample({Key? key}) : super(key: key);

  @override
  State<SquareJoyStickExample> createState() => _SquareJoyStickExampleState();
}

class _SquareJoyStickExampleState extends State<SquareJoyStickExample> {
  double _x = 100;
  double _y = 100;
  JoystickMode _joystickMode = JoystickMode.all;

  @override
  void didChangeDependencies() {
    _x = MediaQuery.of(context).size.width / 2 - ballSize / 2;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text("Sqaure Joystick"),
        actions: [
          JoystickModeDropdown(
              mode: _joystickMode,
              onChanged: (JoystickMode value) {
                setState(() {
                  _joystickMode = value;
                });
              }),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: Colors.green),
            Ball(_x, _y),
            Align(
              alignment: const Alignment(0, 0.8),
              child: Joystick(
                mode: _joystickMode,
                base: JoystickSquareBase(mode: _joystickMode),
                stickOffsetCalculator: const RectangleStickOffsetCalculator(),
                listener: (details) {
                  setState(() {
                    _x = _x + step * details.x;
                    _y = _y + step * details.y;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
