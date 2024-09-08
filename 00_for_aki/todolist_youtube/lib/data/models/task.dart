// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final String title;
  final String note;
  final String time;
  final String date;
  // final TaskCategory category;
  final bool isCompleted;

  const Task(
      {this.id,
      required this.title,
      required this.note,
      required this.time,
      required this.date,
      required this.isCompleted});

  @override
  List<Object> get props {
    return [
      id!,
      title,
      note,
      time,
      date,
      isCompleted,
    ];
  }
}
