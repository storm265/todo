import 'package:flutter/material.dart';
import 'package:todo/data/data_source/archieve/archieve_data_source_impl.dart';
import 'package:todo/data/data_source/category/category_data_source_impl.dart';
import 'package:todo/data/data_source/tasks/tasks_data_source_impl.dart';
import 'package:todo/data/repository/archieve/archieve_repository_impl.dart';
import 'package:todo/data/repository/category/category_repository_impl.dart';
import 'package:todo/data/repository/task/tasks_repository_impl.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';
import 'package:todo/screens/widgets/drawer_widget.dart';
import 'package:todo/screens/task_list/widgets/current_date_widget.dart';
import 'package:todo/screens/task_list/widgets/day_line_widget.dart';
import 'package:todo/screens/task_list/widgets/task_body/body/gradient_boxes.dart';
import 'package:todo/screens/task_list/widgets/schedule_appbar_widget.dart';
import 'package:todo/screens/task_list/widgets/task_body/dialogs/task_list_options_dialog.dart';
import 'package:todo/screens/task_list/widgets/tasks_list.dart';
import 'package:todo/services/common/category_index_provider.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final _taskListController = TaskListController(
    categoryRepository: CategoryRepositoryImpl(
      categoryDataSource: CategoryDataSourceImpl(),
    ),
    archieveRepository: ArchieveRepositoryImpl(
      archieveDataSource: ArchieveDataSourceImpl(),
    ),
    categoryIndexProvider: CategoryIndexProvider(),
    taskRepository: TasksRepositoryImpl(
      tasksDataSource: TasksDataSourceImpl(),
    ),
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await TaskListOptionsDialog.showOptionsDialog(
          buildContext: context,
          taskListController: _taskListController,
        ),
        child: const Icon(Icons.add),
      ),
      drawer: const CustomDrawerWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BodyColors.schreduleBody,
              child: Column(
                children: <Widget>[
                  const ScheduleAppBarWidget(),
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
            TaskList(
              taskListController: _taskListController,
              selectedDate: _taskListController.selectedDate.value,
            ),
          ],
        ),
      ),
    );
  }
}
