import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:todo/service/common/category_finder.dart';
import 'package:todo/routes/delayed_navigator_extension.dart';
import 'package:todo/routes/routers.dart';
import 'package:todo/screens/task/widgets/task_body/dialog/dialog_button.dart';

class TaskListDialog {
  Future<void> showAddDialog(BuildContext buildContext) async =>
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
                    method: () => CategoryFinder()
                        .checkCategoryIsNotEmptyDialog(context)),
                TaskListDialogButton(
                    icon: Icons.post_add_outlined,
                    text: 'Add category',
                    method: () => DelayedNavigator.delayedPush(context,
                        () => Routers.toAddEditCategoryPage(context, 0, false)))
              ],
            );
          });
}
