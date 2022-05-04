import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:todo/controller/task_list/task_list_controller.dart';
import 'package:todo/widgets/task_list_page/date_line_fonts.dart';

class DayLineWidget extends StatefulWidget {
  final Function(DateTime) changeDay;

  const DayLineWidget({Key? key, required this.changeDay}) : super(key: key);

  @override
  State<DayLineWidget> createState() => _DayLineWidgetState();
}

class _DayLineWidgetState extends State<DayLineWidget> {
  final _taskListController = TaskListController();

  @override
  void initState() {
    _taskListController.generateCalendar();
    _taskListController.findIndexThenScroll();
    _taskListController.updateCalendar(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _taskListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 150,
        child: PageView.builder(
          controller: _taskListController.pageController,
          itemCount: _taskListController.calendar.value.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final _calendar = _taskListController.calendar.value;
            return GestureDetector(
                onTap: () {
                  widget.changeDay(_taskListController.selectedDate.value =
                      _calendar[index]);

                  _taskListController.findIndexThenScroll();
                },
                child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Column(
                      children: [
                        Text(DateFormat('d').format(_calendar[index]),
                            style: (_taskListController.selectedDate.value ==
                                    _calendar[index])
                                ? DateLineFonts.t1
                                : DateLineFonts().t2),
                        Text(
                          DateFormat('EEEE')
                              .format(_calendar[index])
                              .substring(0, 3),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ],
                    )));
          },
        ));
  }
}
