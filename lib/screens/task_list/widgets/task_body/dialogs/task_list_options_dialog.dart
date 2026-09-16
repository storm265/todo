import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';
import 'package:todo/services/route_service/route_service.gr.dart';

class TaskListOptionsDialog {
  static Future<void> showOptionsDialog({
    required BuildContext buildContext,
    required TaskListController taskListController,
  }) {
    final router = AutoRouter.of(buildContext);
    return showCupertinoModalPopup<void>(
      context: buildContext,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Add to your day'),
        message: const Text(
          'Plan a task or create a category to keep it organized.',
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              if (await taskListController.isNotEmptyCategory(buildContext) &&
                  buildContext.mounted) {
                await router.push(const AddTaskRoute());
              }
            },
            child: const Text('New task'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              router.push(AddCategoryRoute(index: 0, isEdit: false));
            },
            child: const Text('New category'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}
