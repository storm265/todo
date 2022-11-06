import 'package:flutter/material.dart';
import 'package:todo/screens/task/controller/task_list_controller.dart';
import 'package:todo/screens/common_widgets/drawer_widget.dart';
import 'package:todo/screens/task/widgets/current_date_widget.dart';
import 'package:todo/screens/task/widgets/dateline_lib.dart';
import 'package:todo/screens/task/widgets/task_body/body/gradient_boxes.dart';
import 'package:todo/screens/task/widgets/schedule_appbar_widget.dart';
import 'package:todo/screens/task/widgets/task_list.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final _taskListController = TaskListController();

  @override
  void dispose() {
    _taskListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(backgroundColor: Colors.black),
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
              selectedDate: _taskListController.selectedDate.value,
            ),
          ],
        ),
      ),
    );
  }
}
