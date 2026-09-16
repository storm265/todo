import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show DateUtils;
import 'package:intl/intl.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';

class DayLineWidget extends StatelessWidget {
  const DayLineWidget({super.key, required this.taskListController});
  final TaskListController taskListController;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: taskListController.tasksListenable,
    builder: (context, tasks, _) => ValueListenableBuilder(
      valueListenable: taskListController.selectedDate,
      builder: (context, selectedDate, _) => ValueListenableBuilder(
        valueListenable: taskListController.calendar,
        builder: (context, calendar, _) => PageView.builder(
          controller: taskListController.pageController,
          itemCount: calendar.length,
          itemBuilder: (context, index) {
            final day = calendar[index];
            final selected = DateUtils.isSameDay(day, selectedDate);
            final hasTasks = tasks.values.any(
              (task) =>
                  DateUtils.isSameDay(day, task.deadlineDateTime.toLocal()),
            );
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: GestureDetector(
                onTap: () {
                  taskListController.selectedDate.value = day;
                  taskListController.scrollToSelectedIndex();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white.withValues(
                      alpha: selected ? 0.25 : 0.08,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: selected
                        ? Border.all(
                            color: CupertinoColors.white.withValues(alpha: 0.5),
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEE').format(day),
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '${day.day}',
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Semantics(
                        label: hasTasks ? 'В этот день есть задачи' : null,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasTasks
                                ? CupertinoColors.white
                                : CupertinoColors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
