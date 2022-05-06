// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/common/string_time_formatter.dart';
import 'package:todo/controller/global_controller.dart';
import 'package:todo/repository/category_repository.dart';
import 'package:todo/repository/tasks_repository.dart';

import '../../model/category_bd/category_model.dart';

class EditTaskController {
  void getEditData(
    int index,
  ) {
    var _taskBox = TasksRepository().database.getAt(index)!;
    var _time = TimeOfDay.fromDateTime(_taskBox.deadlineDateTime ?? DateTime.now());

    final _formatter = StringTimeFormatter();
    addEditController.hour = _formatter.formatTime(_time.hour);
    addEditController.min = _formatter.formatTime(_time.minute);

    addEditController.timeTextController.text =
        '${addEditController.hour}:${addEditController.min}';

    addEditController.stringDate.value =
        _taskBox.deadlineDateTime.toString().substring(0, 10);
    addEditController.pickedTime.value =
        TimeOfDay(hour: _time.hour, minute: _time.minute);

    addEditController.convertedDateTime.value =
        _taskBox.deadlineDateTime.toString();

    addEditController.dateTextController.text =
        '${_formatter.formatTime(_taskBox.deadlineDateTime!.day)}.${_formatter.formatTime(_taskBox.deadlineDateTime!.month)}.${_taskBox.deadlineDateTime!.year}';

    addEditController.titleTextController.text = _taskBox.text;

    addEditController.selectedCategory.value = getCategoryIndex(index);
  }

  int getCategoryIndex(
    int index,
  ) {
    Box<CategoryModel> _categoryBox = CategoryRepository().database;
    for (int i = 0; i < _categoryBox.length; i++) {
      if (_categoryBox.getAt(i)!.title ==
          TasksRepository().database.getAt(index)!.category) {
        return addEditController.selectedCategory.value = i;
      }
    }
    return 0;
  }
}
