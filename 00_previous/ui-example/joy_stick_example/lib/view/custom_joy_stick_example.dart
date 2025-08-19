import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:joy_stick_example/util/const.dart';
import 'package:joy_stick_example/view/sub_view/ball.dart';
import 'package:joy_stick_example/view/sub_view/custom_joystick_base.dart';
import 'package:joy_stick_example/view/sub_view/custom_joystick_stick.dart';
import 'package:joy_stick_example/view/sub_view/joy_stick_mode_dropdown.dart';

class CustomJoyStickExample extends StatefulWidget {
  const CustomJoyStickExample({Key? key}) : super(key: key);

  @override
  State<CustomJoyStickExample> createState() => _CustomJoyStickExampleState();
}

class _CustomJoyStickExampleState extends State<CustomJoyStickExample> {
  double _x = 100;
  double _y = 100;

  double detailsX = 0;
  double detailsY = 0;
  String _result = "중 중";
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
        title: const Text("JoyStick"),
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
              alignment: const Alignment(0, -0.8),
              child: Text(
                  "details.x: $detailsX, details.y: $detailsY \n $_result"),
            ),
            Align(
              alignment: const Alignment(0, 0.8),
              child: Joystick(
                mode: _joystickMode,
                base: CustomJoystickBase(),
                stick: CustomJoystickStick(),
                // period: Duration(milliseconds: 5000),
                listener: (details) {
                  setState(() {
                    final result = checkDetails(details.x, details.y);
                    detailsX = details.x;
                    detailsY = details.y;
                    _result = result;
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

  double tiny_diff = 0.3;

  String checkDetails(double x, double y) {
    String result = "";
    // 상
    if (y < -tiny_diff) {
      result += "상";
    } else if (tiny_diff <= y && y <= tiny_diff) {
      result += "중";
    }
    // 하
    else if (tiny_diff < y) {
      result += "하";
    }
    result += " ";
    // 좌
    if (x < -tiny_diff) {
      result += "좌";
    } else if (tiny_diff <= x && x <= tiny_diff) {
      result += "중";
    }
    // 우
    else if (tiny_diff < x) {
      result += "우";
    }

    return result;
  }
}
