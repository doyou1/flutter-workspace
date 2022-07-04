import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class JoystickModeDropdown extends StatelessWidget {
  const JoystickModeDropdown({Key? key, required this.mode, required this.onChanged}) : super(key: key);
  final JoystickMode mode;
  final ValueChanged<JoystickMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: FittedBox(
          child: DropdownButton(
            value: mode,
            onChanged: (v) {
              onChanged(v as JoystickMode);
            },
            items: const [
              DropdownMenuItem(child: Text("All Directions"), value: JoystickMode.all),
              DropdownMenuItem(child: Text("Vertical and Horizontal"), value: JoystickMode.horizontalAndVertical),
              DropdownMenuItem(child: Text("Horizontal"), value: JoystickMode.horizontal),
              DropdownMenuItem(child: Text("Vertical"), value: JoystickMode.vertical),
            ],
          ),
        ),
      ),
    );
  }
}
