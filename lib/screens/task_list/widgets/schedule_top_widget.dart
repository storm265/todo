import 'package:flutter/cupertino.dart';
import 'package:todo/main.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';
import 'package:todo/screens/task_list/widgets/current_date_widget.dart';
import 'package:todo/screens/task_list/widgets/planner_menu_widget.dart';

class ScheduleTopWidget extends StatelessWidget {
  const ScheduleTopWidget({super.key, required this.taskListController});

  final TaskListController taskListController;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      children: [
        Expanded(
          child: CurrentDateWidget(taskListController: taskListController),
        ),

        CupertinoButton(
          padding: const EdgeInsets.all(10),
          onPressed: () => themeController.switchTheme(context),
          child: Icon(
            CupertinoTheme.of(context).brightness == Brightness.dark
                ? CupertinoIcons.sun_max
                : CupertinoIcons.moon,
            color: CupertinoColors.white,
            size: 22,
          ),
        ),
        CupertinoButton(
          padding: const EdgeInsets.all(10),
          onPressed: () => PlannerMenuWidget.show(context),
          child: const Icon(
            CupertinoIcons.square_grid_2x2,
            color: CupertinoColors.white,
            size: 22,
          ),
        ),
      ],
    ),
  );
}
