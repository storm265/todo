import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/common/string_time_formatter.dart';
import 'package:todo/controller/global_controller.dart';
import 'package:todo/data/model/category_bd/category_model.dart';
import 'package:todo/data/repository/category_repository.dart';
import 'package:todo/data/repository/tasks_repository.dart';

class EditTaskController {
  final CategoryRepositoryImpl _categoryRepositoryImpl;
  final TasksRepositoryImpl _tasksRepositoryImpl;

  EditTaskController({
    required CategoryRepositoryImpl categoryRepositoryImpl,
    required TasksRepositoryImpl tasksRepositoryImpl,
  })  : _categoryRepositoryImpl = categoryRepositoryImpl,
        _tasksRepositoryImpl = tasksRepositoryImpl;

  void getEditData(int index) {
    final _taskBox = _tasksRepositoryImpl.database.getAt(index)!;
    final _time =
        TimeOfDay.fromDateTime(_taskBox.deadlineDateTime ?? DateTime.now());

    final _formatter = StringTimeFormatter();
    addEditController.hour = _formatter.formatTime(_time.hour);
    addEditController.min = _formatter.formatTime(_time.minute);

    addEditController.timeTextController.text =
        '${addEditController.hour}:${addEditController.min}';

    addEditController.stringDate.value =
        _taskBox.deadlineDateTime.toString().substring(0, 10);
    addEditController.pickedTime.value =
        TimeOfDay(hour: _time.hour, minute: _time.minute);

    addEditController.convertedDateTime =
        _taskBox.deadlineDateTime.toString();

    addEditController.dateTextController.text =
        '${_formatter.formatTime(_taskBox.deadlineDateTime!.day)}.${_formatter.formatTime(_taskBox.deadlineDateTime!.month)}.${_taskBox.deadlineDateTime!.year}';

    addEditController.titleTextController.text = _taskBox.text;

    addEditController.selectedCategory.value = getCategoryIndex(index);
  }

  int getCategoryIndex(int index) {
    Box<CategoryModel> _categoryBox = _categoryRepositoryImpl.database;
    for (int i = 0; i < _categoryBox.length; i++) {
      if (_categoryBox.getAt(i)!.title ==
          _tasksRepositoryImpl.database.getAt(index)!.category) {
        return addEditController.selectedCategory.value = i;
      }
    }
    return 0;
  }
}
