
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_getx_example/view/my_todo_screen.dart';

import '../model/todo.dart';

class TodoController extends GetxController {
  var todos = [].obs;
  var done = [].obs;
  var remaining = [].obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();

  void addTodoForView() {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty) return;
    var todo = Todo(
      id: UniqueKey().toString(),
      title: titleController.text,
      description: descriptionController.text,
      cdt: DateTime.now(),
    );
    titleController.text = '';
    descriptionController.text = '';
    addTodo(todo);
  }

  @override
  void onInit() {
    try {
      Hive.registerAdapter(TodoAdapter());
    } catch(e) {
      print(e);
    }

    getTodos();
    super.onInit();
  }

  addTodo(Todo todo) async {
    todos.add(todo);
    var box = await Hive.openBox("db");
    box.put("todos", todos.toList());
    print("To Do Object added $todos");

    Get.off(() => MyTodoScreen());
  }

  getTodos() async {
    Box box;
    print("Getting todos");
    try {
      box = Hive.box("db");
    } catch(error) {
      box = await Hive.openBox("db");
      print(error);
    }

    var _todos = box.get("todos");
    print("Todos $_todos");
    if(_todos != null) todos.value = _todos;
    for(Todo todo in todos) {
      if(todo.isDone) {
        done.add(todo);
      } else {
        remaining.add(todo);
      }
    }
  }

  clearTodos() {
    try {
      Hive.deleteBoxFromDisk('db');
    } catch(error) {
      print(error);
    }

    todos.value = [];
  }

  deleteTodo(Todo todo) async {
    todos.remove(todo);
    var box = await Hive.openBox("db");
    box.put("todos", todos.toList());
  }

  toggleTodo(Todo todo) async {
    var index = todos.indexOf(todo);
    var editTodo = todos[index];
    editTodo.isDone = !editTodo.isDone;
    if(editTodo.isDone) {
      done.add(editTodo);
      remaining.remove(editTodo);
    } else {
      done.remove(editTodo);
      remaining.add(editTodo);
    }
    todos[index] = editTodo;
    var box = await Hive.openBox("db");
    box.put("todos", todos.toList());
  }
}