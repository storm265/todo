import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/data/repository/archieve/archieve_repository.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/data/repository/task/tasks_repository.dart';
import 'package:todo/main.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';
import 'package:todo/screens/task_list/widgets/current_date_widget.dart';
import 'package:todo/screens/task_list/widgets/day_line_widget.dart';
import 'package:todo/screens/task_list/widgets/task_body/body/gradient_boxes.dart';
import 'package:todo/screens/task_list/widgets/schedule_top_widget.dart';
import 'package:todo/screens/task_list/widgets/task_body/dialogs/task_list_options_dialog.dart';
import 'package:todo/screens/task_list/widgets/tasks_list.dart';
import 'package:todo/services/common/category_index_provider.dart';
import 'package:todo/services/locator_service.dart';

@RoutePage()
class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final _taskListController = TaskListController(
    categoryRepository: serviceLocator<CategoryRepository<CategoryModel>>(),
    archieveRepository: serviceLocator<ArchieveRepository<ArchieveModel>>(),
    categoryIndexProvider: CategoryIndexProvider(),
    taskRepository: serviceLocator<TasksRepository<TaskModel>>(),
  );

  @override
  void initState() {
    _taskListController.generateCalendarElements();
    _taskListController.scrollToSelectedIndex();
    _taskListController.updateCalendarElements(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        left: false,
        right: false,
        child: Stack(
          children: [
            Column(
              children: [
                ValueListenableBuilder<CupertinoThemeData>(
                  valueListenable: themeController.currentTheme,
                  builder: (context, theme, _) => Container(
                    decoration: theme.brightness == Brightness.dark
                        ? BodyColors.schreduleBodyDark
                        : BodyColors.schreduleBodyLight,
                    child: Column(
                      children: <Widget>[
                        const ScheduleTopWidget(),
                        CurrentDateWidget(
                          selectedDay: _taskListController.selectedDate.value,
                        ),
                        DayLineWidget(
                          taskListController: _taskListController,
                          changeDay: (value) {
                            setState(() {
                              _taskListController.selectedDate.value = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                TaskList(
                  taskListController: _taskListController,
                  selectedDate: _taskListController.selectedDate.value,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(12),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CupertinoButton.filled(
                  padding: EdgeInsets.all(0),
                  onPressed: () async =>
                      await TaskListOptionsDialog.showOptionsDialog(
                    buildContext: context,
                    taskListController: _taskListController,
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
