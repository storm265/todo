import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/model/tasks/task_model.dart';

abstract class TasksDataSource {
  Box<TaskModel> getDatabase();

  Future<void> saveTask(TaskModel model);

  Future<void> deleteTask(int index);

  Future<void> updateTask({
    required int index,
    required TaskModel model,
  });
}
