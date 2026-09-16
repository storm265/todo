import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/utils/theme_extension.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: context.cardColor,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: context.secondaryTextColor.withValues(alpha: 0.08),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          taskModel.text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: taskModel.isDone
                ? context.secondaryTextColor
                : CupertinoTheme.of(context).textTheme.textStyle.color,
            decoration: taskModel.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                taskModel.category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: context.secondaryTextColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(CupertinoIcons.clock, size: 13, color: context.accentColor),
            const SizedBox(width: 4),
            Text(
              DateFormat('HH:mm').format(taskModel.deadlineDateTime.toLocal()),
              style: TextStyle(
                fontSize: 13,
                color: context.accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
