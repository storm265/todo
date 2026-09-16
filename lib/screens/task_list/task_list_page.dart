import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/data/repository/archieve/archieve_repository.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/data/repository/task/tasks_repository.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';
import 'package:todo/screens/task_list/widgets/planner_header_widget.dart';
import 'package:todo/screens/task_list/widgets/task_body/dialogs/task_list_options_dialog.dart';
import 'package:todo/screens/task_list/widgets/tasks_list.dart';
import 'package:todo/services/common/category_index_provider.dart';
import 'package:todo/services/locator_service.dart';

@RoutePage()
class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});
  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final _controller = TaskListController(
    categoryRepository: serviceLocator<CategoryRepository<CategoryModel>>(),
    archieveRepository: serviceLocator<ArchieveRepository<ArchieveModel>>(),
    categoryIndexProvider: CategoryIndexProvider(),
    taskRepository: serviceLocator<TasksRepository<TaskModel>>(),
  );

  @override
  void initState() {
    super.initState();
    _controller.generateCalendarElements();
    _controller.scrollToSelectedIndex();
    _controller.updateCalendarElements();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    child: Padding(
      padding: EdgeInsetsGeometry.only(
        top: MediaQuery.paddingOf(context).top,
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      child: Stack(
        clipBehavior: .none,
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: PlannerHeaderWidget(controller: _controller),
              ),
              TaskList(taskListController: _controller),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 18,
            child: CupertinoButton.filled(
              borderRadius: BorderRadius.circular(20),
              onPressed: () => TaskListOptionsDialog.showOptionsDialog(
                buildContext: context,
                taskListController: _controller,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.add, size: 21),
                  SizedBox(width: 8),
                  Text(
                    'New task',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
