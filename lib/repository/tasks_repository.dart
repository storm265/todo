import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/model/tasks_db/task_model.dart';
import 'package:todo/repository/repository.dart';

class TasksRepository implements Repository<TaskModel> {
  final taskDatabase = Hive.box<TaskModel>('tasks');

  @override
  Future<void> save(TaskModel model) async {
    try {
      await taskDatabase.add(model);
    } catch (e) {
      debugPrint('TasksRepository save error!');
    }
  }

  @override  
  Box<TaskModel> getDatabase() {
    try {
      return taskDatabase;
    } catch (e) {
      debugPrint('TasksRepository save error!');
    }
    return taskDatabase;
  }

  @override
  void delete(int index) {
    try {
      taskDatabase.deleteAt(index);
    } catch (e) {
      debugPrint('TasksRepository delete error!');
    }
  }
}
