import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/screens/task/controller/task_list_controller.dart';
import 'package:todo/screens/task/widgets/date_line_fonts.dart';

class DayLineWidget extends StatefulWidget {
  final Function(DateTime) changeDay;

  const DayLineWidget({
    Key? key,
    required this.changeDay,
  }) : super(key: key);

  @override
  State<DayLineWidget> createState() => _DayLineWidgetState();
}

class _DayLineWidgetState extends State<DayLineWidget> {
  final _taskListController = TaskListController();

  @override
  void initState() {
    _taskListController.generateCalendarElements();
    _taskListController.scrollToSelectedIndex();
    _taskListController.updateCalendarElements(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _taskListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PageView.builder(
        controller: _taskListController.pageController,
        itemCount: _taskListController.calendar.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          final calendar = _taskListController.calendar;
          return GestureDetector(
            onTap: () {
              widget.changeDay(
                  _taskListController.selectedDate.value = calendar[i]);

              _taskListController.scrollToSelectedIndex();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Column(
                children: [
                  FittedBox(
                    child: Text(
                      DateFormat('d').format(calendar[i]),
                      style: (_taskListController.selectedDate.value ==
                              calendar[i])
                          ? DateLineFonts.selected
                          : DateLineFonts.unSelected,
                    ),
                  ),
                  Text(
                    DateFormat('EEEE').format(calendar[i]).substring(0, 3),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
