import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show DateUtils;
import 'package:todo/screens/task_list/controller/task_list_controller.dart';
import 'package:todo/screens/task_list/widgets/task_item_widget.dart';
import 'package:todo/screens/widgets/empty_state_widget.dart';
import 'package:todo/utils/theme_extension.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.taskListController});
  final TaskListController taskListController;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: taskListController.tasksListenable,
    builder: (context, box, _) => ValueListenableBuilder(
      valueListenable: taskListController.selectedDate,
      builder: (context, selectedDate, _) {
        final indices = List.generate(box.length, (index) => index)
            .where(
              (index) => DateUtils.isSameDay(
                box.getAt(index)!.deadlineDateTime.toLocal(),
                selectedDate,
              ),
            )
            .toList();
        indices.sort(
          (a, b) => box
              .getAt(a)!
              .deadlineDateTime
              .compareTo(box.getAt(b)!.deadlineDateTime),
        );
        if (indices.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyStateWidget(
              title: 'A clear day ahead',
              description: 'Add a task and make room for what matters.',
            ),
          );
        }
        final completed = indices
            .where((index) => box.getAt(index)!.isDone)
            .length;
        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
          sliver: SliverList.builder(
            itemCount: indices.length + 1,
            itemBuilder: (context, row) {
              if (row == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                  child: Row(
                    children: [
                      const Text(
                        'Your tasks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '$completed/${indices.length} done',
                        style: TextStyle(
                          fontSize: 13,
                          color: context.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                );
              }
              final index = indices[row - 1];
              return TaskItemWidget(
                task: box.getAt(index)!,
                index: index,
                controller: taskListController,
              );
            },
          ),
        );
      },
    ),
  );
}
