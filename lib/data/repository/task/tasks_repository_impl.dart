import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/data_source/tasks/task_data_source.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/data/repository/task/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksDataSource _tasksDataSource;

  TasksRepositoryImpl({required TasksDataSource tasksDataSource})
      : _tasksDataSource = tasksDataSource;

  @override
  Box<TaskModel> getDatabase() => _tasksDataSource.getDatabase();

  @override
  Future<void> saveTask(TaskModel model) => _tasksDataSource.saveTask(model);

  @override
  Future<void> deleteTask(int index) => _tasksDataSource.deleteTask(index);

  @override
  Future<void> updateTask({
    required int index,
    required TaskModel model,
  }) =>
      _tasksDataSource.updateTask(
        index: index,
        model: model,
      );
}
