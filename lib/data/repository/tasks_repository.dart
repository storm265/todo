import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/tasks/task_model.dart';

class TasksRepositoryImpl {
  final _taskDatabase = Hive.box<TaskModel>(DbScheme.tasks);

  Box<TaskModel> get database => _taskDatabase;

  Future<void> saveTask(TaskModel model) async =>
      await _taskDatabase.add(model);

  Future<void> deleteTask(int index) async =>
      await _taskDatabase.deleteAt(index);

  Future<void> updateTask({
    required int index,
    required TaskModel model,
  }) async =>
      await _taskDatabase.putAt(
        index,
        model,
      );
}
