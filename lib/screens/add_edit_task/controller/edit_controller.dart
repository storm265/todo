import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/common/string_time_formatter.dart';
import 'package:todo/controller/global_controller.dart';
import 'package:todo/data/model/category/category_model.dart';
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
    final taskBox = _tasksRepositoryImpl.database.getAt(index)!;
    final time =
        TimeOfDay.fromDateTime(taskBox.deadlineDateTime ?? DateTime.now());

    final formatter = StringTimeFormatter();
    addEditController.hour = formatter.formatTime(time.hour);
    addEditController.min = formatter.formatTime(time.minute);

    addEditController.timeTextController.text =
        '${addEditController.hour}:${addEditController.min}';

    addEditController.stringDate.value =
        taskBox.deadlineDateTime.toString().substring(0, 10);
    addEditController.pickedTime.value =
        TimeOfDay(hour: time.hour, minute: time.minute);

    addEditController.convertedDateTime =
        taskBox.deadlineDateTime.toString();

    addEditController.dateTextController.text =
        '${formatter.formatTime(taskBox.deadlineDateTime!.day)}.${formatter.formatTime(taskBox.deadlineDateTime!.month)}.${taskBox.deadlineDateTime!.year}';

    addEditController.titleTextController.text = taskBox.text;

    addEditController.selectedCategory.value = getCategoryIndex(index);
  }

  int getCategoryIndex(int index) {
    Box<CategoryModel> categoryBox = _categoryRepositoryImpl.database;
    for (int i = 0; i < categoryBox.length; i++) {
      if (categoryBox.getAt(i)!.title ==
          _tasksRepositoryImpl.database.getAt(index)!.category) {
        return addEditController.selectedCategory.value = i;
      }
    }
    return 0;
  }
}
