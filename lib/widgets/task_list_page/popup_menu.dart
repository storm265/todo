import 'package:flutter/material.dart';

import 'package:todo/controller/task_list/popup_buttons_controller.dart';
import 'package:todo/controller/task_list/task_list_controller.dart';

class PopupMenuWidget extends StatelessWidget {
  PopupMenuWidget({Key? key}) : super(key: key);
  final taskListCtller = TaskListController();
  final _popupButtonsController = PopupButtonsController();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        child: const Icon(
          Icons.more_horiz,
          color: Colors.black54,
          size: 40,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () =>
                    _popupButtonsController.onMarkAsDoneClicked(context),
                child: Text(
                    "Mark as done: ${taskListCtller.canMarkAsDone.value ? 'On' : 'Off'}"),
                value: 1,
              ),
              PopupMenuItem(
                onTap: () => _popupButtonsController.onEditTaskClicked(context),
                child: Text(
                    "Edit: ${taskListCtller.canEdit.value ? 'On' : 'Off'}"),
                value: 2,
              ),
              PopupMenuItem(
                onTap: () => _popupButtonsController.onDeleteClicked(context),
                child: Text(
                    "Delete: ${taskListCtller.canRemove.value ? 'On' : 'Off'}"),
                value: 3,
              ),
            ]);
  }
}
