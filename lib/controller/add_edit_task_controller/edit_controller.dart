// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/common/string_time_formatter.dart';
import 'package:todo/controller/global_variables.dart';
import 'package:todo/repository/category_repository.dart';
import 'package:todo/repository/tasks_repository.dart';

import '../../model/category_bd/category_model.dart';

class EditTaskController {
  void getEditData(int index) {
    var task = TasksRepository().getDatabase().getAt(index)!;
    var time = TimeOfDay.fromDateTime(task.deadlineDateTime ?? DateTime.now());

    final _formatter = StringTimeFormatter();
    addEditController.hour = _formatter.formatTime(time.hour);
    addEditController.min = _formatter.formatTime(time.minute);

    addEditController.timeTextController.text =
        '${addEditController.hour}:${addEditController.min}';

    addEditController.stringDate.value =
        task.deadlineDateTime.toString().substring(0, 10);
    addEditController.pickedTime.value =
        TimeOfDay(hour: time.hour, minute: time.minute);

    addEditController.convertedDateTime.value = task.deadlineDateTime.toString();

    addEditController.dateTextController.text =
        '${_formatter.formatTime(task.deadlineDateTime!.day)}.${_formatter.formatTime(task.deadlineDateTime!.month)}.${task.deadlineDateTime!.year}';

    addEditController.titleTextController.text = task.text;

    addEditController.selectedCategory.value = getCategoryIndex(index);
  }

  int getCategoryIndex(int index) {
    Box<CategoryModel> categoryBox = CategoryRepository().getDatabase();
    for (int i = 0; i < categoryBox.length; i++) {
      if (categoryBox.getAt(i)!.title ==
          TasksRepository().getDatabase().getAt(index)!.category) {
        return addEditController.selectedCategory.value = i;
      }
    }
    return 0;
  }
}
