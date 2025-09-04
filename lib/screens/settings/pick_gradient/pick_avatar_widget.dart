import 'package:flutter/material.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/data/repository/archieve/archieve_repository.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/data/repository/task/tasks_repository.dart';
import 'package:todo/screens/settings/pick_gradient/select_gradient_item_cubit.dart';
import 'package:todo/screens/task_list/controller/task_list_controller.dart';
import 'package:todo/screens/task_list/widgets/current_date_widget.dart';
import 'package:todo/screens/task_list/widgets/day_line_widget.dart';
import 'package:todo/screens/task_list/widgets/schedule_top_widget.dart';
import 'package:todo/services/common/category_index_provider.dart';
import 'package:todo/services/locator_service.dart';

class PickAvatarWidget extends StatefulWidget {
  const PickAvatarWidget({super.key, required this.selectGradientItemCubit});

  final SelectGradientItemCubit selectGradientItemCubit;

  @override
  State<PickAvatarWidget> createState() => _PickAvatarWidgetState();
}

class _PickAvatarWidgetState extends State<PickAvatarWidget> {
  final _taskListController = TaskListController(
    categoryRepository: serviceLocator<CategoryRepository<CategoryModel>>(),
    archieveRepository: serviceLocator<ArchieveRepository<ArchieveModel>>(),
    categoryIndexProvider: CategoryIndexProvider(),
    taskRepository: serviceLocator<TasksRepository<TaskModel>>(),
  );

  @override
  void initState() {
    _taskListController.generateCalendarElements();
    _taskListController.scrollToSelectedIndex();
    _taskListController.updateCalendarElements(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ValueListenableBuilder<MapEntry>(
        valueListenable: widget.selectGradientItemCubit.selectedGradient,
        builder: (context, selectedGradient, _) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
              )
            ],
            gradient: LinearGradient(
              colors: selectedGradient.value,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            children: <Widget>[
              IgnorePointer(child: const ScheduleTopWidget()),
              CurrentDateWidget(
                selectedDay: _taskListController.selectedDate.value,
              ),
              DayLineWidget(
                taskListController: _taskListController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
