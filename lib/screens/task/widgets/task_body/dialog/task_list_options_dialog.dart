import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:todo/routes/delayed_navigator_extension.dart';
import 'package:todo/routes/routers.dart';
import 'package:todo/screens/task/controller/task_list_controller.dart';
import 'package:todo/screens/task/widgets/task_body/dialog/dialog_button.dart';

class TaskListOptionsDialog {
  static Future<void> showOptionsDialog({
    required BuildContext buildContext,
    required TaskListController taskListController,
  }) async =>
      await showDialog(
        barrierColor: Colors.black54,
        context: buildContext,
        builder: (context) {
          return PlatformAlertDialog(
            title: const Text('Chose option'),
            actions: [
              TaskListDialogButton(
                icon: Icons.add_task_outlined,
                text: 'Add task',
                method: () => taskListController.isNotEmptyCategory(context)
                    ? Routers.toAddTaskPage(context)
                    : null,
              ),
              TaskListDialogButton(
                icon: Icons.post_add_outlined,
                text: 'Add category',
                method: () async => await DelayedNavigator.delayedPush(
                  context,
                  () => Routers.toAddEditCategoryPage(context, 0, false),
                ),
              )
            ],
          );
        },
      );
}
