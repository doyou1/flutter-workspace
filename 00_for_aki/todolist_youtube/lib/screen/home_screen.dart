import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist_youtube/config/routes/routes.dart';
import 'package:todolist_youtube/data/data.dart';
import 'package:todolist_youtube/utils/utils.dart';
import 'package:todolist_youtube/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) => const HomeScreen();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Scaffold(
        body: Stack(
      children: [
        /** Banner */
        Column(
          children: [
            Container(
              height: deviceSize.height * 0.3,
              width: deviceSize.width,
              color: Theme.of(context).colorScheme.primary,
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
                  const DisplayListOfTasks(
                    tasks: [
                      Task(
                          title: "title",
                          note: "detail note....",
                          time: "10:12",
                          date: "Aug, 9",
                          isCompleted: false,
                          category: TaskCategories.others),
                      Task(
                          title: "title title title",
                          note: "",
                          time: "10:12",
                          date: "Aug, 9",
                          isCompleted: false,
                          category: TaskCategories.home)
                    ],
                    isCompletedTasks: false,
                  ),
                  const Gap(20),
                  Text(
                    "Completed",
                    style: context.textTheme.headlineMedium,
                  ),
                  const DisplayListOfTasks(
                    tasks: [
                      Task(
                          title: "title",
                          note: "note",
                          time: "10:12",
                          date: "Aug, 9",
                          isCompleted: true,
                          category: TaskCategories.personal),
                      Task(
                          title: "title title title",
                          note: "note",
                          time: "10:12",
                          date: "Aug, 9",
                          isCompleted: true,
                          category: TaskCategories.health)
                    ],
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
}


// now let's create the add task screen