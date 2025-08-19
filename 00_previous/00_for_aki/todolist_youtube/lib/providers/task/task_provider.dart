import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist_youtube/data/data.dart';
import 'package:todolist_youtube/providers/providers.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});

// now let's consume all