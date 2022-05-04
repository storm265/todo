import 'package:flutter/material.dart';

import 'package:todo/controller/task_list/task_list_controller.dart';
import 'package:todo/widgets/common/custom_snackbar_widget.dart';

class PopupButtonsController {
  final taskListCtller = TaskListController();
  void onMarkAsDoneClicked(BuildContext context) {
    taskListCtller.canMarkAsDone.value = !taskListCtller.canMarkAsDone.value;
    // disable others
    if (taskListCtller.canMarkAsDone.value) {
      taskListCtller.canRemove.value = false;
      taskListCtller.canEdit.value = false;
    }

    if (taskListCtller.canMarkAsDone.value) {
      CustomSnackbarWidget()
          .showCustomSnackbar(context, 'Tap on task to mark as done.');
    }
  }

  void onEditTaskClicked(BuildContext context) {
    taskListCtller.canEdit.value = !taskListCtller.canEdit.value;
    // disable others
    if (taskListCtller.canEdit.value) {
      taskListCtller.canRemove.value = false;
      taskListCtller.canMarkAsDone.value = false;
    }

    if (taskListCtller.canEdit.value) {
      CustomSnackbarWidget()
          .showCustomSnackbar(context, 'Tap on task to edit.');
    }
  }

  void onDeleteClicked(BuildContext context) {
    taskListCtller.canRemove.value = !taskListCtller.canRemove.value;
    // disable others
    if (taskListCtller.canRemove.value) {
      taskListCtller.canMarkAsDone.value = false;
      taskListCtller.canEdit.value = false;
    }
    if (taskListCtller.canRemove.value) {
      CustomSnackbarWidget()
          .showCustomSnackbar(context, 'Tap on task to remove.');
    }
  }

  void onAddToArchieveClicked(BuildContext context) {
    taskListCtller.canAddToArchieve.value =
        !taskListCtller.canAddToArchieve.value;
    // disable others
    if (taskListCtller.canAddToArchieve.value) {
      CustomSnackbarWidget()
          .showCustomSnackbar(context, 'Tap on task to add in archieve.');
      taskListCtller.canRemove.value = false;
      taskListCtller.canMarkAsDone.value = false;
      taskListCtller.canEdit.value = false;
    }
  }
}
