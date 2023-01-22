import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
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
    final time = TimeOfDay.fromDateTime(taskBox.deadlineDateTime);

    addEditController.timeTextController.text =
        DateFormat.jm().format(taskBox.deadlineDateTime);

    addEditController.pickedTime.value =
        TimeOfDay(hour: time.hour, minute: time.minute);

    addEditController.convertedDateTime = taskBox.deadlineDateTime;

    addEditController.dateTextController.text =
        DateFormat.yMd().format(taskBox.deadlineDateTime);

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
