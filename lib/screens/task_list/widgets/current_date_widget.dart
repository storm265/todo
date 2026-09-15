import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';

class CurrentDateWidget extends StatelessWidget {
  const CurrentDateWidget({
    super.key,
    required this.taskListController,
  });

final TaskListController taskListController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Center(
        child: 
       ValueListenableBuilder(valueListenable: taskListController.selectedDate, builder: (context, selectedDate, _) =>  Text(
          '${DateFormat("MMMM").format(selectedDate)}, ${selectedDate.year}',
          style: const TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
        ),),
      ),
    );
  }
}
