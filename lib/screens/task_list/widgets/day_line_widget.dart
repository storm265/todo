import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';

class DayLineWidget extends StatefulWidget {
  final TaskListController taskListController;

  const DayLineWidget({
    super.key,
    required this.taskListController,
  });

  @override
  State<DayLineWidget> createState() => _DayLineWidgetState();
}

class _DayLineWidgetState extends State<DayLineWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: widget.taskListController.tasksListenable,
        builder: (__, tasksListenable, _) => ValueListenableBuilder(
          valueListenable: widget.taskListController.selectedDate,
          builder: (__, selectedDate, _) => ValueListenableBuilder(
            valueListenable: widget.taskListController.calendar,
            builder: (__, calendarList, _) => PageView.builder(
              controller: widget.taskListController.pageController,
              itemCount: calendarList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) => GestureDetector(
                onTap: () {
                  widget.taskListController.selectedDate.value =
                      calendarList[i];

                  widget.taskListController.scrollToSelectedIndex();
                },
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        DateFormat('d').format(calendarList[i]),
                        style: (selectedDate == calendarList[i])
                            ? TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 60,
                                color: Colors.white,
                              )
                            : TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 55,
                                color: Colors.white70,
                              ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        DateFormat('EEEE')
                            .format(calendarList[i])
                            .substring(0, 3),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    if (tasksListenable.values
                            .where(
                              (element) =>
                                  DateFormat.yMd().format(calendarList[i]) ==
                                  DateFormat.yMd()
                                      .format(element.deadlineDateTime),
                            )
                            .firstOrNull !=
                        null)
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.white,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
