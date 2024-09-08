import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist_youtube/app/todo_app.dart';

void main() {
  runApp(const ProviderScope(child: TodoApp()));
}

