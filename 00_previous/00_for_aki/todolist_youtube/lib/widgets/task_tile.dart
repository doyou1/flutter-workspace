import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todolist_youtube/data/data.dart';
import 'package:todolist_youtube/providers/providers.dart';
import 'package:todolist_youtube/utils/extensions.dart';
import 'package:todolist_youtube/widgets/widgets.dart';

class TaskTile extends ConsumerWidget {
  const TaskTile({super.key, required this.task, this.onChanged});

  final Task task;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = context.textTheme;
    final double iconOpacity = task.isCompleted ? 0.3 : 0.5;
    final double backgroundOpacity = task.isCompleted ? 0.1 : 0.3;
    final textDecoration =
        task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
    final fontWeight = task.isCompleted ? FontWeight.normal : FontWeight.bold;

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
      child: Row(
        children: [
          CircleContainer(
            color: task.category.color.withOpacity(backgroundOpacity),
            child: Center(
              child: Icon(task.category.icon,
                  color: task.category.color.withOpacity(iconOpacity)),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title,
                    style: style.titleMedium?.copyWith(
                      decoration: textDecoration,
                      fontSize: 20,
                      fontWeight: fontWeight,
                    )),
                Text(task.time,
                    style: style.titleMedium?.copyWith(
                      decoration: textDecoration,
                      fontWeight: fontWeight,
                    )),
              ],
            ),
          ),
          InkWell(
              onTap: () async {
                await ref.read(taskProvider.notifier).updateTask(task);
              },
              child: Checkbox(value: task.isCompleted, onChanged: onChanged))
        ],
      ),
    );
  }
}
