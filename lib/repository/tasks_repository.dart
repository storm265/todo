import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/error_controller/error_service.dart';
import 'package:todo/model/tasks_db/task_model.dart';
import 'package:todo/repository/repository.dart';

class TasksRepository implements Repository<TaskModel> {
  final _taskDatabase = Hive.box<TaskModel>('tasks');

  @override
  Box<TaskModel> get database => _taskDatabase;

  @override
  Future<void> save(TaskModel model) async {
    try {
      await _taskDatabase.add(model);
    } catch (e) {
     ErrorService.printError('$e');
    }
  }

  @override
  Future<void> delete(int index) async{
    try {
      await _taskDatabase.deleteAt(index);
    } catch (e) {
     ErrorService.printError('$e');
    }
  }
}
