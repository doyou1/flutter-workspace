import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_getx_example/view/my_todo_screen.dart';
import 'package:hive_getx_example/view/add_todo_screen.dart';
import 'package:hive_getx_example/view/sub_view/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset("images/logo.png"),
            height: 150,
          ),
          Center(
            child: Text(
              "Welcome To",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              "My Todo App help you stay organized and perform your tasks much faster.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(height: 50),
          // SizedBox(
          //   height: 50,
          //   child: OutlinedButton.icon(
          //     onPressed: () {
          //       Get.to(() => AddTodoScreen());
          //     },
          //     icon: const Icon(Icons.add),
          //     label: const Text("Add Todo"),
          //   ),
          // ),
          CustomButton(
            height: 50.0,
            onPressed: () {
              Get.to(() => AddTodoScreen());
            },
            color: Colors.blue,
            title: "Add Todo",
            icon: Icons.add,
          ),
          SizedBox(height: 20),
          // SizedBox(
          //   height: 50,
          //   child: OutlinedButton.icon(
          //     onPressed: () {
          //       Get.to(() => MyTodoScreen());
          //     },
          //     icon: const Icon(Icons.task),
          //     label: const Text("My Todo"),
          //   ),
          // ),
          CustomButton(
            height: 50.0,
            onPressed: () {
              Get.to(() => MyTodoScreen());
            },
            title: "My Todo",
            icon: Icons.task,
          ),
        ],
      ),
    );
  }
}
