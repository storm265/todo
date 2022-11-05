import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/tasks_db/task_model.dart';
import 'package:todo/data/repository/repository.dart';

class TasksRepositoryImpl implements Repository<TaskModel> {
  final _taskDatabase = Hive.box<TaskModel>(DbScheme.tasks);

  @override
  Box<TaskModel> get database => _taskDatabase;

  @override
  Future<void> save(TaskModel model) async => await _taskDatabase.add(model);

  @override
  Future<void> delete(int index) async => await _taskDatabase.deleteAt(index);
}
