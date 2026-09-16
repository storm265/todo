import 'package:flutter/cupertino.dart';
import 'package:todo/main.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';
import 'package:todo/screens/task_list/widgets/day_line_widget.dart';
import 'package:todo/screens/task_list/widgets/schedule_top_widget.dart';

class PlannerHeaderWidget extends StatelessWidget {
  const PlannerHeaderWidget({super.key, required this.controller});

  final TaskListController controller;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<MapEntry<String, List<Color>>>(
        valueListenable: pickAvatarController.selectedGradient,
        builder: (context, gradient, _) => Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: gradient.value,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              ScheduleTopWidget(taskListController: controller),
              const SizedBox(height: 14),
              SizedBox(
                height: 94,
                child: DayLineWidget(taskListController: controller),
              ),
            ],
          ),
        ),
      );
}
