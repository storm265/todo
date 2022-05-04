import 'package:flutter/material.dart';

import 'package:todo/controller/task_list/task_list_controller.dart';
import 'package:todo/widgets/common/drawer_widget.dart';
import 'package:todo/widgets/task_list_page/appbar_widget.dart';
import 'package:todo/widgets/task_list_page/current_date_widget.dart';
import 'package:todo/widgets/task_list_page/dateline_lib.dart';
import 'package:todo/widgets/task_list_page/task_body/body/gradient_boxes.dart';
import 'package:todo/widgets/task_list_page/schedule_appbar_widget.dart';
import 'package:todo/widgets/task_list_page/task_list.dart';

class TaskListPage extends StatelessWidget {
   TaskListPage({Key? key}) : super(key: key);
   
  final taskListCtller = TaskListController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EmptyAppBarWidget().emptyAppBar,
        drawer: const CustomDrawerWidget(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Builder(builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    Container(
                      height: 250, //250
                      decoration: BodyColors.schreduleBody,
                      child: Column(
                        children: <Widget>[
                          const ScheduleAppBarWidget(),
                          CurrentDateWidget(
                            selectedDay: taskListCtller.selectedDate.value,
                          ),
                          DayLineWidget(
                            changeDay: (value) {
                              setState(() {
                                taskListCtller.selectedDate.value = value;
                                
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    TaskList(
                      selectedDate: taskListCtller.selectedDate.value,
                    ),
                  ],
                );
              },
            );
          }),
        ));
  }
}
