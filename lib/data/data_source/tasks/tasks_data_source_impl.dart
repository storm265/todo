import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/data_source/tasks/task_data_source.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/tasks/task_model.dart';

class TasksDataSourceImpl implements TasksDataSource {
  final _taskDatabase = Hive.box<TaskModel>(DbScheme.tasks);

  @override
  Box<TaskModel> getDatabase() => _taskDatabase;

  @override
  Future<void> saveTask(TaskModel model) async =>
      await _taskDatabase.add(model);

  @override
  Future<void> deleteTask(int index) async =>
      await _taskDatabase.deleteAt(index);

  @override
  Future<void> updateTask({
    required int index,
    required TaskModel model,
  }) async =>
      await _taskDatabase.putAt(
        index,
        model,
      );
}
