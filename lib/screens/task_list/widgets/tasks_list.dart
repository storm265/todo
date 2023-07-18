import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import 'package:todo/services/route_service.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/screens/task_list/widgets/task_body/connectors/connector_done_widget.dart';
import 'package:todo/screens/task_list/widgets/task_body/connectors/connector_not_done_widget.dart';
import 'package:todo/screens/task_list/widgets/task_body/icons/icon_not_done_widget.dart';
import 'package:todo/screens/task_list/widgets/task_body/body/task_card_widget.dart';
import 'package:todo/screens/task_list/widgets/task_body/icons/icon_done_widget.dart';

class TaskList extends StatelessWidget {
  final TaskListController taskListController;
  final DateTime selectedDate;

  const TaskList({
    Key? key,
    required this.selectedDate,
    required this.taskListController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: taskListController.getTaskDataBase().listenable(),
        builder: (_, Box<TaskModel> box, __) {
          return box.values.isEmpty
              ? const SizedBox()
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: box.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, i) {
                    TaskModel? task = box.getAt(i);
                    DateTime? deadline = task!.deadlineDateTime;

                    if (DateFormat.yMd().format(deadline) ==
                        DateFormat.yMd().format(selectedDate)) {
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              flex: 2,
                              onPressed: (_) =>
                                  taskListController.isNotEmptyCategory(context)
                                      ? RouteService.toEditTaskPage(
                                          context, task, i)
                                      : null,
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                            SlidableAction(
                              flex: 2,
                              onPressed: (task.isDone)
                                  ? null
                                  : (_) async => await taskListController
                                      .markTaskAsDone(task: task, index: i),
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.done,
                              label: 'Done',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              flex: 2,
                              onPressed: (_) async {
                                await taskListController.pushTaskToArchieve(
                                    task: task);
                                await taskListController.deleteTask(index: i);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.archive,
                              label: 'Remove',
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TimelineTile(
                            node: TimelineNode(
                              indicator: (task.isDone)
                                  ? const IconDoneWidget()
                                  : const IconNotDoneWidget(),
                              startConnector: (task.isDone)
                                  ? const ConnectorDoneWidget()
                                  : const ConnectorNotDoneWidget(),
                              endConnector: (task.isDone)
                                  ? const ConnectorDoneWidget()
                                  : const ConnectorNotDoneWidget(),
                            ),
                            oppositeContents: null,
                            nodeAlign: TimelineNodeAlign.start,
                            contents: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  DateFormat('hh:mm a').format(deadline),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TaskCardWidget(taskModel: task),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  });
        });
  }
}
