import 'package:flutter/material.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/theme_extension.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskCardWidget({
    super.key,
    required this.taskModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ValueListenableBuilder<MapEntry<String, List<Color>>>(
        valueListenable: pickAvatarController.selectedGradient,
        builder: (context, selectedGradient, _) => Container(
          width: 250,
          height: 85,
          padding: EdgeInsets.all(8.0),
          decoration: taskModel.isDone
              ? BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                    )
                  ],
                  gradient: LinearGradient(
                    colors: selectedGradient.value,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: context.isLightMode()
                          ? Colors.black26
                          : Colors.white30,
                      blurRadius: 10,
                    )
                  ],
                  color: context.isLightMode() ? Colors.white : Colors.black87,
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                taskModel.text,
                maxLines: 2,
                style: TextStyle(
                  color: taskModel.isDone
                      ? Colors.white
                      : context.isLightMode()
                          ? Colors.black87
                          : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                taskModel.category,
                style: TextStyle(
                  color: taskModel.isDone
                      ? Colors.white
                      : context.isLightMode()
                          ? Colors.black87
                          : Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
