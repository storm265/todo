// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/global_variables.dart';
import 'package:todo/repository/category_repository.dart';
import 'package:todo/repository/tasks_repository.dart';

import '../../model/category_bd/category_model.dart';

class EditTaskController {
  void getEditData(int index) {
    var task = TasksRepository().getDatabase().getAt(index)!;
    var time = TimeOfDay.fromDateTime(task.deadlineDateTime ?? DateTime.now());

    addEditCtller.hour = time.hour.toString();
    addEditCtller.min = time.minute.toString();
    addEditCtller.timeTextController.text =
        '${addEditCtller.hour}:${addEditCtller.min}';

    addEditCtller.stringDate.value =
        task.deadlineDateTime.toString().substring(0, 10);
    addEditCtller.pickedTime.value =
        TimeOfDay(hour: time.hour, minute: time.minute);

    // String _hour = (task.deadlineDateTime!.hour.toString().length == 1)
    //     ? '0${task.deadlineDateTime!.hour}'
    //     : addEditCtller.pickedTime.value.hour.toString();
    // String _min = (task.deadlineDateTime!.minute.toString().length == 1)
    //     ? '0${task.deadlineDateTime!.minute}'
    //     : addEditCtller.pickedTime.value.minute.toString();

    addEditCtller.convertedDateTime.value =
        '${addEditCtller.stringDate.value} ${addEditCtller.hour}:${addEditCtller.min}:00.000000';
    addEditCtller.convertedDateTime.value = task.deadlineDateTime.toString();

    addEditCtller.dateTextController.text =
        '${task.deadlineDateTime!.day}/${task.deadlineDateTime!.month}/${task.deadlineDateTime!.year}';

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
