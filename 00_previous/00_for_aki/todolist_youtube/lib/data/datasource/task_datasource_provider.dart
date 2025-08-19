import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist_youtube/data/data.dart';

final taskDatasourceProvider = Provider<TaskDatasource>((ref) {
  return TaskDatasource();
});