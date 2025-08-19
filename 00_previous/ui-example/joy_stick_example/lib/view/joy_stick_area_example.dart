import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:joy_stick_example/util/const.dart';
import 'package:joy_stick_example/view/sub_view/ball.dart';
import 'package:joy_stick_example/view/sub_view/joy_stick_mode_dropdown.dart';

class JoyStickAreaExample extends StatefulWidget {
  const JoyStickAreaExample({Key? key}) : super(key: key);

  @override
  State<JoyStickAreaExample> createState() => _JoyStickAreaExampleState();
}

class _JoyStickAreaExampleState extends State<JoyStickAreaExample> {
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
        title: const Text("JoyStick Area"),
        actions: [
          JoystickModeDropdown(
            mode: _joystickMode,
            onChanged: (JoystickMode value) {
              setState(() {
                _joystickMode = value;
              });
            }
          ),
        ],
      ),
      body: SafeArea(
        child: JoystickArea(
          mode: _joystickMode,
          initialJoystickAlignment: const Alignment(0, 0.8),
          listener: (details) {
            setState(() {
              _x = _x + step * details.x;
              _y = _y + step * details.y;
            });
          },
          child: Stack(
            children: [
              Container(color: Colors.green,),
              Ball(_x, _y),
            ],
          ),
        ),
      ),
    );
  }
}
