import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class Task {
  final String task;
  final bool isFinish;
  const Task(this.task, this.isFinish);
}

final List<Task> _taskList = [
  const Task("Call Tom about appointment", false),
  const Task("Fix onboarding experience", false),
  const Task("Edit API documentation", false),
  const Task("Setup user focus group", false),
  const Task("Have coffe with Sam", true),
  const Task("Meet with sales", true),
];

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: _taskList.length,
      itemBuilder: (context, index) {
        return _taskList[index].isFinish
            ? _taskcomplete(_taskList[index].task)
            : _taskUncomplete(_taskList[index].task);
      },
    );
  }

  Padding _taskUncomplete(String task) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 24.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.radio_button_unchecked,
            color: Theme.of(context).colorScheme.secondary,
            size: 20,
          ),
          const SizedBox(
            width: 28,
          ),
          Text(task)
        ],
      ),
    );
  }

  Container _taskcomplete(String task) {
    return Container(
      foregroundDecoration: const BoxDecoration(color: Color(0x60FDFDFD)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 24.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.radio_button_checked,
              color: Theme.of(context).colorScheme.secondary,
              size: 20,
            ),
            const SizedBox(
              width: 28,
            ),
            Text(task)
          ],
        ),
      ),
    );
  }
}
