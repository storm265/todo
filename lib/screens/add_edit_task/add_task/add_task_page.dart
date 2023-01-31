import 'package:flutter/material.dart';
import 'package:todo/data/data_source/archieve/archieve_data_source_impl.dart';
import 'package:todo/data/data_source/category/category_data_source_impl.dart';
import 'package:todo/data/data_source/tasks/tasks_data_source_impl.dart';
import 'package:todo/data/repository/archieve/archieve_repository_impl.dart';
import 'package:todo/data/repository/category/category_repository_impl.dart';
import 'package:todo/data/repository/task/tasks_repository_impl.dart';
import 'package:todo/screens/add_edit_task/add_task/controller/add_task_controller.dart';
import 'package:todo/screens/add_edit_task/add_task/widgets/category_list_widget.dart';
import 'package:todo/screens/add_edit_task/add_task/widgets/textfield.dart';
import 'package:todo/screens/common_widgets/custom_app_bar_widget.dart';
import 'package:todo/screens/common_widgets/unfocus_widget.dart';
import 'package:todo/screens/task/controller/task_validator.dart';
import 'package:todo/service/common/category_index_provider.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleTextController = TextEditingController();
  final _dateTextController = TextEditingController();
  final _timeTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _addTaskController = AddTaskController(
    archieveRepository: ArchieveRepositoryImpl(
      archieveDataSource: ArchieveDataSourceImpl(),
    ),
    categoryIndexerProvider: CategoryIndexProvider(),
    categoryRepository: CategoryRepositoryImpl(
      categoryDataSource: CategoryDataSourceImpl(),
    ),
    taskValidator: TaskValidator(),
    tasksRepository: TasksRepositoryImpl(
      tasksDataSource: TasksDataSourceImpl(),
    ),
  );
  @override
  void dispose() {
    _titleTextController.dispose();
    _dateTextController.dispose();
    _timeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        context: context,
        showActions: false,
        title: 'Add task',
      ),
      body: UnfocusWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddEditTaskTextfieldWidget(
                textEditingController: _titleTextController,
                hintText: 'Text:',
                enabled: true,
              ),
              AddEditTaskTextfieldWidget(
                textEditingController: _dateTextController,
                hintText: 'Finish date:',
              ),
              OutlinedButton.icon(
                onPressed: () async => await _addTaskController.pickDate(
                  context: context,
                  dateTextController: _dateTextController,
                ),
                icon: const Icon(Icons.date_range_outlined),
                label: const Text('Pick date'),
              ),
              AddEditTaskTextfieldWidget(
                textEditingController: _timeTextController,
                hintText: 'Finish time:',
              ),
              OutlinedButton.icon(
                onPressed: () async => await _addTaskController.pickTime(
                    timeTextController: _timeTextController, context: context),
                icon: const Icon(Icons.schedule_outlined),
                label: const Text('Pick time'),
              ),
              CategoryListWidget(
                taskController: _addTaskController,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _addTaskController.isSubmitActive,
                builder: (context, value, _) {
                  return OutlinedButton.icon(
                    onPressed: _addTaskController.isSubmitActive.value
                        ? () async {
                            // TODO finish
                            // await _addTaskController.validateForm(
                            //   context: context,
                            //   callback: () => _addTaskController.createTask(
                            //     categoryTitle: widget.model.category,
                            //     context: context,
                            //     title: _titleTextController.text,
                            //   ),
                            //   formKey: _formKey,
                            // );
                          }
                        : null,
                    icon: const Icon(Icons.save),
                    label: const Text('Add task'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
