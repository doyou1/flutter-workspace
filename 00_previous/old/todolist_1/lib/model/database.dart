import 'dart:io';

import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:todolist_1/model/todo.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called todos_file.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, "db.sqlite"));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [
  Todo
], queries: {
  '_getByType': 'SELECT * FROM todo WHERE todo_type = ?',
  '_completeTask': 'UPDATE todo SET is_finish = 1 WHERE id = ?',
  '_deleteTask': 'DELETE FROM todo WHERE id = ?'
})
class Database extends _$Database {
  // we tell the database where to store the data with this constructor
  Database() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  Stream<List<TodoData>> getTodoByType(int type) => _getByType(type).watch();

  Future insertTodoEntries(TodoData entry) {
    return transaction(() async {
      await into(todo).insert(entry);
    });
  }

  Future completeTodoEntries(int id) {
    return transaction(() async {
      await _completeTask(id);
    });
  }

  Future deleteTodoEntries(int id) {
    return transaction(() async {
      await _deleteTask(id);
    });
  }
}
