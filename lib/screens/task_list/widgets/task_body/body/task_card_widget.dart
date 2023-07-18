import 'package:flutter/material.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/screens/task_list/widgets/task_body/body/gradient_boxes.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskCardWidget({
    Key? key,
    required this.taskModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        height: 85,
        padding: const EdgeInsets.all(8.0),
        decoration: taskModel.isDone
            ? BodyColors.gradientTaskBody
            : BodyColors.emptyTaskBody,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              taskModel.text,
              maxLines: 2,
              style:  TextStyle(
                color:taskModel.isDone ? Colors.white : Colors.black87,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              taskModel.category,
              style:  TextStyle(
                color: taskModel.isDone ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
