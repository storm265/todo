import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/screens/task_list/controller/task_controller.dart';
import 'package:todo/data/model/category/category_model.dart';

class EditTaskController extends TaskController {
  EditTaskController({
    required super.taskValidator,
    required super.tasksRepository,
    required super.categoryIndexerProvider,
    required super.archieveRepository,
    required super.categoryRepository,
  });

  Future<void> updateTask({
    required String selectedCategory,
    required String title,
    required int index,
    required BuildContext context,
  }) =>
      tasksRepository
          .updateTask(
            index: index,
            model: TaskModel(
              id: categoryIndexerProvider.getCategoryIndex(selectedCategory),
              isDone: false,
              category: selectedCategory,
              creationDate: DateTime.now(),
              text: title,
              deadlineDateTime: convertedDateTime!,
            ),
          )
          .then(
            (_) => showMessage(context, 'Task updated 😊 🚀.'),
          );

  void getEditData({
    required int index,
    required TextEditingController timeTextController,
    required TextEditingController dateTextController,
    required TextEditingController titleTextController,
  }) {
    final taskBox = tasksRepository.getDatabase().getAt(index)!;
    final time = TimeOfDay.fromDateTime(taskBox.deadlineDateTime);

    timeTextController.text = DateFormat.jm().format(taskBox.deadlineDateTime);

    pickedTime.value = TimeOfDay(hour: time.hour, minute: time.minute);

    convertedDateTime = taskBox.deadlineDateTime;

    dateTextController.text = DateFormat.yMd().format(taskBox.deadlineDateTime);

    titleTextController.text = taskBox.text;

    selectedCategoryIndex.value = getCategoryIndex(index);
  }

  int getCategoryIndex(int index) {
    Box<CategoryModel> categoryBox = categoryRepository.getDatabase();
    for (int i = 0; i < categoryBox.length; i++) {
      if (categoryBox.getAt(i)!.title ==
          tasksRepository.getDatabase().getAt(index)!.category) {
        return selectedCategoryIndex.value = i;
      }
    }
    return 0;
  }
}
