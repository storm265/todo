import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';

class CurrentDateWidget extends StatelessWidget {
  const CurrentDateWidget({super.key, required this.taskListController});
  final TaskListController taskListController;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: taskListController.selectedDate,
    builder: (context, date, _) => Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        DateFormat('MMMM').format(date),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: CupertinoColors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
