import 'package:flutter/material.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/screens/task_list/controller/task_controller.dart';

class AddTaskController extends TaskController {
  AddTaskController({
    required super.taskValidator,
    required super.tasksRepository,
    required super.categoryIndexerProvider,
    required super.archieveRepository,
    required super.categoryRepository,
  });

  Future<void> createTask({
    required BuildContext context,
    required String title,
  }) async {
    final categoryTitle = categoryRepository
        .getDatabase()
        .getAt(selectedCategoryIndex.value)!
        .title;

    await tasksRepository
        .saveTask(
          TaskModel(
            id: categoryIndexerProvider.getCategoryIndex(categoryTitle),
            isDone: false,
            category: categoryTitle,
            creationDate: DateTime.now(),
            text: title,
            deadlineDateTime: convertedDateTime!,
          ),
        )
        .then(
          (_) => showMessage(context, 'Task added😊 🚀.'),
        );
  }
}
