import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist_youtube/config/config.dart';
import 'package:todolist_youtube/data/data.dart';
import 'package:todolist_youtube/providers/providers.dart';
import 'package:todolist_youtube/utils/utils.dart';
import 'package:todolist_youtube/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    final compltedTasks = _completedTasks(taskState.tasks);
    final incompltedTasks = _incompletedTasks(taskState.tasks);

    return Scaffold(
        body: Stack(
      children: [
        /** Banner */
        Column(
          children: [
            Container(
              height: deviceSize.height * 0.3,
              width: deviceSize.width,
              color: colors.primary,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DisplayWhiteText(
                    text: 'Aug 7, 2023',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                  DisplayWhiteText(text: 'My Todo List', fontSize: 40),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 180,
          left: 0,
          right: 0,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DisplayListOfTasks(
                    tasks: incompltedTasks,
                  ),
                  const Gap(20),
                  Text(
                    "Completed",
                    style: context.textTheme.headlineMedium,
                  ),
                  DisplayListOfTasks(
                    tasks: compltedTasks,
                    isCompletedTasks: true,
                  ),
                  const Gap(20),
                  ElevatedButton(
                      onPressed: () => context.push(RouteLocation.createTask),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DisplayWhiteText(text: "Add New Task"),
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  List<Task> _incompletedTasks(List<Task> tasks) {
    final List<Task> filtered = [];
    for (var task in tasks) {
      if (!task.isCompleted) {
        filtered.add(task);
      }
    }
    return filtered;
  }

  List<Task> _completedTasks(List<Task> tasks) {
    final List<Task> filtered = [];
    for (var task in tasks) {
      if (task.isCompleted) {
        filtered.add(task);
      }
    }
    return filtered;
  }
}