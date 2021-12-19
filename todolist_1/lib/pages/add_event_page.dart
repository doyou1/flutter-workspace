import "package:flutter/material.dart";
import 'package:todolist_1/widgets/custom_button.dart';
import 'package:todolist_1/widgets/custom_textfield.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
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
            child: Text("Add new event",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextField(labelText: "Enter event name"),
          const SizedBox(height: 12),
          CustomTextField(labelText: "Enter description"),
          const SizedBox(height: 12),
          _dateTimePicker(Icons.date_range, _pickDate, _selectedDate),
          _dateTimePicker(Icons.access_time, _pickTime, _selectedTime),
          const SizedBox(height: 24),
          _actionButton(context),
        ],
      ),
    );
  }

  Widget _dateTimePicker(IconData icon, VoidCallback onPressed, String value) {
    return TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(value, style: const TextStyle(fontSize: 14))
            ],
          ),
        ));
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
