import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todolist_youtube/data/data.dart';
import 'package:todolist_youtube/utils/extensions.dart';
import 'package:todolist_youtube/widgets/widgets.dart';

class DisplayListOfTasks extends StatelessWidget {
  const DisplayListOfTasks(
      {super.key, required this.tasks, this.isCompletedTasks = false});

  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emptyTasksMessage = isCompletedTasks
        ? "There is no completed task yet"
        : "There is no task todo!";

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTasksMessage,
                style: context.textTheme.headlineSmall,
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => Text("Home")),
    );
  }
}
