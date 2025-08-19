import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist_youtube/utils/utils.dart';

final categoryProvider = StateProvider<TaskCategories>((ref) {
  return TaskCategories.education;
}); 