import 'package:flutter/material.dart';
import 'package:hive_getx_example/controller/todo_controller.dart';
import 'package:get/get.dart';
import 'package:hive_getx_example/model/todo.dart';
import 'package:hive_getx_example/view/add_todo_screen.dart';
import 'package:hive_getx_example/view/sub_view/todo_card.dart';
import 'package:hive_getx_example/view/todo_detail_screen.dart';

class MyTodoScreen extends StatelessWidget {
  final controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.off(() => AddTodoScreen());
          },
          label: Row(
            children: [
              Icon(Icons.add),
              SizedBox(width: 10),
              Text("Add todo"),
            ],
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                  Text(
                    "My Todos",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  // for title Text align center
                  SizedBox(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Completed",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: _buildCompleted(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Remaining",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: _buildInCompleted(),
            ),
          ],
        ));
  }

  Widget _buildCompleted() {
    return Obx(
        () => Container(
          child: ListView.builder(

              padding: EdgeInsets.zero,
              itemCount: controller.done.length,
              itemBuilder: (context, index) {
              Todo todo = controller.done[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => TodoDetailScreen(todo: todo));
                },
                onLongPress: () {
                  controller.toggleTodo(todo);
                },
                child: TodoCard(
                  isDone: todo.isDone,
                  title: todo.title,
                  date: todo.cdt,
                ),
              );
          },),
        ),
    );
  }

  Widget _buildInCompleted() {
    return Obx(
        () => Container(
          child: ListView.builder(
              itemCount: controller.remaining.length,
              itemBuilder: (context, index) {
                Todo todo = controller.remaining[index];
                return GestureDetector(
                  onLongPress: () {
                    controller.toggleTodo(todo);
                  },
                  child: TodoCard(
                    isDone: todo.isDone,
                    title: todo.title,
                    date: todo.cdt,
                  ),
                );
          }),
        ),
    );
  }
}
