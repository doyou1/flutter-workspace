// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TodoData extends DataClass implements Insertable<TodoData> {
  final int id;
  final DateTime date;
  final DateTime time;
  final String task;
  final String description;
  final bool isFinish;
  final int todoType;
  TodoData(
      {required this.id,
      required this.date,
      required this.time,
      required this.task,
      required this.description,
      required this.isFinish,
      required this.todoType});
  factory TodoData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TodoData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      time: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time'])!,
      task: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}task'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      isFinish: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_finish'])!,
      todoType: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}todo_type'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['time'] = Variable<DateTime>(time);
    map['task'] = Variable<String>(task);
    map['description'] = Variable<String>(description);
    map['is_finish'] = Variable<bool>(isFinish);
    map['todo_type'] = Variable<int>(todoType);
    return map;
  }

  TodoCompanion toCompanion(bool nullToAbsent) {
    return TodoCompanion(
      id: Value(id),
      date: Value(date),
      time: Value(time),
      task: Value(task),
      description: Value(description),
      isFinish: Value(isFinish),
      todoType: Value(todoType),
    );
  }

  factory TodoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TodoData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      time: serializer.fromJson<DateTime>(json['time']),
      task: serializer.fromJson<String>(json['task']),
      description: serializer.fromJson<String>(json['description']),
      isFinish: serializer.fromJson<bool>(json['isFinish']),
      todoType: serializer.fromJson<int>(json['todoType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'time': serializer.toJson<DateTime>(time),
      'task': serializer.toJson<String>(task),
      'description': serializer.toJson<String>(description),
      'isFinish': serializer.toJson<bool>(isFinish),
      'todoType': serializer.toJson<int>(todoType),
    };
  }

  TodoData copyWith(
          {int? id,
          DateTime? date,
          DateTime? time,
          String? task,
          String? description,
          bool? isFinish,
          int? todoType}) =>
      TodoData(
        id: id ?? this.id,
        date: date ?? this.date,
        time: time ?? this.time,
        task: task ?? this.task,
        description: description ?? this.description,
        isFinish: isFinish ?? this.isFinish,
        todoType: todoType ?? this.todoType,
      );
  @override
  String toString() {
    return (StringBuffer('TodoData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('task: $task, ')
          ..write('description: $description, ')
          ..write('isFinish: $isFinish, ')
          ..write('todoType: $todoType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, time, task, description, isFinish, todoType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoData &&
          other.id == this.id &&
          other.date == this.date &&
          other.time == this.time &&
          other.task == this.task &&
          other.description == this.description &&
          other.isFinish == this.isFinish &&
          other.todoType == this.todoType);
}

class TodoCompanion extends UpdateCompanion<TodoData> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<DateTime> time;
  final Value<String> task;
  final Value<String> description;
  final Value<bool> isFinish;
  final Value<int> todoType;
  const TodoCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.task = const Value.absent(),
    this.description = const Value.absent(),
    this.isFinish = const Value.absent(),
    this.todoType = const Value.absent(),
  });
  TodoCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required DateTime time,
    required String task,
    required String description,
    required bool isFinish,
    required int todoType,
  })  : date = Value(date),
        time = Value(time),
        task = Value(task),
        description = Value(description),
        isFinish = Value(isFinish),
        todoType = Value(todoType);
  static Insertable<TodoData> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<DateTime>? time,
    Expression<String>? task,
    Expression<String>? description,
    Expression<bool>? isFinish,
    Expression<int>? todoType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (task != null) 'task': task,
      if (description != null) 'description': description,
      if (isFinish != null) 'is_finish': isFinish,
      if (todoType != null) 'todo_type': todoType,
    });
  }

  TodoCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<DateTime>? time,
      Value<String>? task,
      Value<String>? description,
      Value<bool>? isFinish,
      Value<int>? todoType}) {
    return TodoCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      time: time ?? this.time,
      task: task ?? this.task,
      description: description ?? this.description,
      isFinish: isFinish ?? this.isFinish,
      todoType: todoType ?? this.todoType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (task.present) {
      map['task'] = Variable<String>(task.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isFinish.present) {
      map['is_finish'] = Variable<bool>(isFinish.value);
    }
    if (todoType.present) {
      map['todo_type'] = Variable<int>(todoType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('task: $task, ')
          ..write('description: $description, ')
          ..write('isFinish: $isFinish, ')
          ..write('todoType: $todoType')
          ..write(')'))
        .toString();
  }
}

class $TodoTable extends Todo with TableInfo<$TodoTable, TodoData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TodoTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime?> time = GeneratedColumn<DateTime?>(
      'time', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _taskMeta = const VerificationMeta('task');
  @override
  late final GeneratedColumn<String?> task = GeneratedColumn<String?>(
      'task', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isFinishMeta = const VerificationMeta('isFinish');
  @override
  late final GeneratedColumn<bool?> isFinish = GeneratedColumn<bool?>(
      'is_finish', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_finish IN (0, 1))');
  final VerificationMeta _todoTypeMeta = const VerificationMeta('todoType');
  @override
  late final GeneratedColumn<int?> todoType = GeneratedColumn<int?>(
      'todo_type', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, time, task, description, isFinish, todoType];
  @override
  String get aliasedName => _alias ?? 'todo';
  @override
  String get actualTableName => 'todo';
  @override
  VerificationContext validateIntegrity(Insertable<TodoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('task')) {
      context.handle(
          _taskMeta, task.isAcceptableOrUnknown(data['task']!, _taskMeta));
    } else if (isInserting) {
      context.missing(_taskMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('is_finish')) {
      context.handle(_isFinishMeta,
          isFinish.isAcceptableOrUnknown(data['is_finish']!, _isFinishMeta));
    } else if (isInserting) {
      context.missing(_isFinishMeta);
    }
    if (data.containsKey('todo_type')) {
      context.handle(_todoTypeMeta,
          todoType.isAcceptableOrUnknown(data['todo_type']!, _todoTypeMeta));
    } else if (isInserting) {
      context.missing(_todoTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TodoData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodoTable createAlias(String alias) {
    return $TodoTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodoTable todo = $TodoTable(this);
  Selectable<TodoData> _getByType(int var1) {
    return customSelect('SELECT * FROM todo WHERE todo_type = ?', variables: [
      Variable<int>(var1)
    ], readsFrom: {
      todo,
    }).map(todo.mapFromRow);
  }

  Future<int> _completeTask(int var1) {
    return customUpdate(
      'UPDATE todo SET is_finish = 1 WHERE id = ?',
      variables: [Variable<int>(var1)],
      updates: {todo},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> _deleteTask(int var1) {
    return customUpdate(
      'DELETE FROM todo WHERE id = ?',
      variables: [Variable<int>(var1)],
      updates: {todo},
      updateKind: UpdateKind.delete,
    );
  }

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todo];
}
