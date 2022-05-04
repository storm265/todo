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
    addEditCtller.hour = _formatter.formatTime(time.hour);
    addEditCtller.min = _formatter.formatTime(time.minute);

    addEditCtller.timeTextController.text =
        '${addEditCtller.hour}:${addEditCtller.min}';

    addEditCtller.stringDate.value =
        task.deadlineDateTime.toString().substring(0, 10);
    addEditCtller.pickedTime.value =
        TimeOfDay(hour: time.hour, minute: time.minute);

    addEditCtller.convertedDateTime.value = task.deadlineDateTime.toString();

    addEditCtller.dateTextController.text =
        '${_formatter.formatTime(task.deadlineDateTime!.day)}.${_formatter.formatTime(task.deadlineDateTime!.month)}.${task.deadlineDateTime!.year}';

    addEditCtller.titleTextController.text = task.text;

    addEditCtller.selectedCategory.value = getCategoryIndex(index);
  }

  int getCategoryIndex(int index) {
    Box<CategoryModel> categoryBox = CategoryRepository().getDatabase();
    for (int i = 0; i < categoryBox.length; i++) {
      if (categoryBox.getAt(i)!.title ==
          TasksRepository().getDatabase().getAt(index)!.category) {
        return addEditCtller.selectedCategory.value = i;
      }
    }
    return 0;
  }
}
