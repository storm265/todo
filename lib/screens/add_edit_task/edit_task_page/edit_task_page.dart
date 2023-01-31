import 'package:flutter/material.dart';
import 'package:todo/data/data_source/archieve/archieve_data_source_impl.dart';
import 'package:todo/data/data_source/category/category_data_source_impl.dart';
import 'package:todo/data/data_source/tasks/tasks_data_source_impl.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/data/repository/archieve/archieve_repository_impl.dart';
import 'package:todo/data/repository/task/tasks_repository_impl.dart';
import 'package:todo/screens/add_edit_task/edit_task_page/edit_task_controller.dart';
import 'package:todo/data/repository/category/category_repository_impl.dart';
import 'package:todo/screens/add_edit_task/add_task/widgets/category_list_widget.dart';
import 'package:todo/screens/add_edit_task/add_task/widgets/textfield.dart';
import 'package:todo/screens/widgets/custom_app_bar_widget.dart';
import 'package:todo/screens/widgets/unfocus_widget.dart';
import 'package:todo/screens/task/controller/task_validator.dart';
import 'package:todo/services/common/category_index_provider.dart';

class EditTaskPage extends StatefulWidget {
  final int taskIndex;
  final TaskModel model;

  const EditTaskPage({
    Key? key,
    required this.taskIndex,
    required this.model,
  }) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _titleTextController = TextEditingController();
  final _dateTextController = TextEditingController();
  final _timeTextController = TextEditingController();

  final _editTaskController = EditTaskController(
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
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _editTaskController.getEditData(
      index: widget.taskIndex,
      timeText: _timeTextController.text,
      dateText: _dateTextController.text,
      title: _titleTextController.text,
    );
    super.initState();
  }

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
        title: 'Edit task',
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
                onPressed: () async => await _editTaskController.pickDate(
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
                onPressed: () async => await _editTaskController.pickTime(
                    timeTextController: _timeTextController, context: context),
                icon: const Icon(Icons.schedule_outlined),
                label: const Text('Pick time'),
              ),
              CategoryListWidget(
                taskController: _editTaskController,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _editTaskController.isSubmitActive,
                builder: (context, value, _) {
                  return OutlinedButton.icon(
                    onPressed: _editTaskController.isSubmitActive.value
                        ? () {
                            _editTaskController.validateForm(
                                context: context,
                                callback: () => _editTaskController.updateTask(
                                      selectedCategory: widget.model.category,
                                      title: _titleTextController.text,
                                      index: widget.taskIndex,
                                      context: context,
                                    ),
                                formKey: _formKey);
                          }
                        : null,
                    icon: const Icon(Icons.add),
                    label: const Text('Update task'),
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
