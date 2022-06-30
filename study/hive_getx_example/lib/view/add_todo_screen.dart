import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_getx_example/view/sub_view/custom_button.dart';
import 'package:hive_getx_example/view/sub_view/custom_text_form_field.dart';

import '../controller/todo_controller.dart';

class AddTodoScreen extends StatelessWidget {
  final controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Add Todo"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 40,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Add your task",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    borderRadius: BorderRadius.circular(25),
                    controller: controller.titleController,
                    height: 50.0,
                    hintText: "Enter todo title",
                    nextFocus: controller.descriptionFocus,
                  ),
                  CustomTextFormField(
                    padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                    borderRadius: BorderRadius.circular(25),
                    controller: controller.descriptionController,
                    height: 100.0,
                    hintText: "Enter description",
                    focus: controller.descriptionFocus,
                    maxLines: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            CustomButton(
              title: "Submit",
              icon: Icons.done,
              onPressed: controller.addTodoForView,
            ),
          ],
        ),
      ),
    );
  }
}
