import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';

class DayLineWidget extends StatefulWidget {
  final TaskListController taskListController;
  final Function(DateTime) changeDay;

  const DayLineWidget({
    super.key,
    required this.changeDay,
    required this.taskListController,
  });

  @override
  State<DayLineWidget> createState() => _DayLineWidgetState();
}

class _DayLineWidgetState extends State<DayLineWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.taskListController.calendar,
      builder: (__, calendarList, _) => ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 80,
          maxHeight: 140,
        ),
        child: PageView.builder(
          controller: widget.taskListController.pageController,
          itemCount: calendarList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: () {
                widget.changeDay(widget.taskListController.selectedDate.value =
                    calendarList[i]);

                widget.taskListController.scrollToSelectedIndex();
              },
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                      DateFormat('d').format(calendarList[i]),
                      style: (widget.taskListController.selectedDate.value ==
                              calendarList[i])
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
                    flex: 1,
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
