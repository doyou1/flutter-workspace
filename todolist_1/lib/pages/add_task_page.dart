import "package:flutter/material.dart";
import 'package:todolist_1/widgets/custom_button.dart';
import 'package:todolist_1/widgets/custom_date_time_picker.dart';
import 'package:todolist_1/widgets/custom_modal_action_button.dart';
import 'package:todolist_1/widgets/custom_textfield.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String _selectedDate = 'Pick date';
  String _selectedTime = 'Pick time';

  Future _pickDate() async {
    DateTime? datepick = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (datepick != null) {
      setState(() {
        _selectedDate = datepick.toString();
      });
    }
  }

  Future _pickTime() async {
    TimeOfDay? timepick =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (timepick != null) {
      setState(() {
        _selectedTime = timepick.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Center(
            child: Text("Add new Task",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextField(labelText: "Enter task name"),
          CustomDateTimePicker(
              onPressed: _pickDate,
              icon: Icons.date_range,
              value: _selectedDate),
          CustomDateTimePicker(
              onPressed: _pickTime,
              icon: Icons.access_time,
              value: _selectedTime),
          CustomModalActionButton(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: () {},
          )
        ],
      ),
    );
  }
}
