import 'package:hive/hive.dart';
part 'task_model.g.dart'; // for build runner

// flutter packages pub run build_runner build --delete-conflicting-outputs
@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime? deadlineDateTime;

  @HiveField(2)
  DateTime creationDate;

  @HiveField(3)
  String category;

  @HiveField(4)
  bool isDone;

  @HiveField(5)
  String text;

  TaskModel(
      {required this.id,
      required this.creationDate,
      required this.deadlineDateTime,
      required this.text,
      required this.category,
      required this.isDone});
}
