import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:todo/controller/common/same_category_finder.dart';
import 'package:todo/controller/task_list/dialog_close_controller.dart';
import 'package:todo/routes/routers.dart';
import 'package:todo/widgets/task_list_page/task_body/dialog/dialog_button.dart';

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
                    method: () => SameCategoryFinder()
                        .checkCategoryIsNotEmptyDialog(context)),
                TaskListDialogButton(
                    icon: Icons.post_add_outlined,
                    text: 'Add category',
                    method: () => DialogDelayedWrapper().delayedPush(
                          context,
                          () => Routers()
                              .toAddEditCategoryPage(context, 0, false),
                        )),
              ],
            );
          });
}
