import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';
import 'package:todo/screens/task_list/widgets/task_body/body/task_card_widget.dart';
import 'package:todo/services/route_service/route_service.gr.dart';
import 'package:todo/utils/theme_extension.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.task,
    required this.index,
    required this.controller,
  });
  final TaskModel task;
  final int index;
  final TaskListController controller;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Slidable(
      key: ValueKey(controller.getTaskDataBase().keyAt(index)),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async {
              final router = AutoRouter.of(context);
              if (await controller.isNotEmptyCategory(context) &&
                  context.mounted) {
                await router.push(EditTaskRoute(taskIndex: index, model: task));
              }
            },
            backgroundColor: context.accentColor,
            foregroundColor: context.isDarkMode() ? Colors.black : Colors.white,
            icon: CupertinoIcons.pencil,
            label: 'Edit',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async {
              await controller.pushTaskToArchieve(task: task);
              await controller.deleteTask(index: index);
            },
            backgroundColor: const Color(0xFFD34F66),
            foregroundColor: Colors.white,
            icon: CupertinoIcons.archivebox,
            label: 'Archive',
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            CupertinoButton(
              padding: const EdgeInsets.all(8),
              onPressed: task.isDone
                  ? null
                  : () => controller.markTaskAsDone(task: task, index: index),
              child: Icon(
                task.isDone
                    ? CupertinoIcons.checkmark_circle_fill
                    : CupertinoIcons.circle,
                color: task.isDone
                    ? context.accentColor
                    : context.secondaryTextColor,
                size: 28,
              ),
            ),
            Expanded(child: TaskCardWidget(taskModel: task)),
          ],
        ),
      ),
    ),
  );
}
