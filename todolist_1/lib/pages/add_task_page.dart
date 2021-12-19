import "package:flutter/material.dart";
import 'package:todolist_1/widgets/custom_button.dart';
import 'package:todolist_1/widgets/custom_textfield.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
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
          _actionButton(context),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          buttonText: "Close",
          color: Colors.white,
          textColor: Theme.of(context).colorScheme.secondary,
        ),
        CustomButton(
            onPressed: () {},
            buttonText: "Save",
            color: Theme.of(context).colorScheme.secondary,
            textColor: Colors.white),
      ],
    );
  }
}
