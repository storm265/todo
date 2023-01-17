import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/tasks/task_model.dart';

class TasksRepositoryImpl {
  final _taskDatabase = Hive.box<TaskModel>(DbScheme.tasks);

  Box<TaskModel> get database => _taskDatabase;

  Future<void> save(TaskModel model) async => await _taskDatabase.add(model);

  Future<void> delete(int index) async => await _taskDatabase.deleteAt(index);
}
