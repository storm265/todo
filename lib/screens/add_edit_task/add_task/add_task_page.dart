import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/data/repository/archieve/archieve_repository.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/data/repository/task/tasks_repository.dart';
import 'package:todo/screens/add_edit_task/add_task/controller/add_task_controller.dart';
import 'package:todo/screens/add_edit_task/add_task/widgets/category_list_widget.dart';
import 'package:todo/screens/add_edit_task/add_task/widgets/textfield_widget.dart';
import 'package:todo/screens/widgets/gradient_appbar_widget.dart';
import 'package:todo/screens/widgets/unfocus_widget.dart';
import 'package:todo/screens/task_list/controller/task_validator.dart';
import 'package:todo/services/common/category_index_provider.dart';
import 'package:todo/services/locator_service.dart';

@RoutePage()
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({
    super.key,
  });

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleTextController = TextEditingController();
  final _dateTextController = TextEditingController();
  final _timeTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _addTaskController = AddTaskController(
    archieveRepository: serviceLocator<ArchieveRepository<ArchieveModel>>(),
    categoryIndexerProvider: CategoryIndexProvider(),
    categoryRepository: serviceLocator<CategoryRepository<CategoryModel>>(),
    taskValidator: TaskValidator(),
    tasksRepository: serviceLocator<TasksRepository<TaskModel>>(),
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
    return CupertinoPageScaffold(
      navigationBar: GradientAppBarWidget(
        showActions: false,
        title: 'Add task',
      ),
      child: UnfocusWidget(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextfieldWidget(
                  validator: (title) => _addTaskController.taskValidator
                      .isTitleValid(text: title),
                  textEditingController: _titleTextController,
                  hintText: 'Text:',
                  enabled: true,
                ),
                TextfieldWidget(
                  validator: (date) =>
                      _addTaskController.taskValidator.isDateValid(text: date),
                  textEditingController: _dateTextController,
                  hintText: 'Finish date:',
                ),
                CupertinoButton(
                  onPressed: () => _addTaskController.pickDate(
                    context: context,
                    dateTextController: _dateTextController,
                  ),
                  child: Row(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.date_range_outlined),
                      const Text('Pick date')
                    ],
                  ),
                ),
                SizedBox(height: 10),
                CategoryListWidget(
                  taskController: _addTaskController,
                ),
                SizedBox(height: 10),
                ValueListenableBuilder<bool>(
                  valueListenable: _addTaskController.isSubmitActive,
                  builder: (context, value, _) {
                    return CupertinoButton.filled(
                      onPressed: _addTaskController.isSubmitActive.value
                          ? () async {
                              await _addTaskController.validateForm(
                                context: context,
                                callback: () async =>
                                    await _addTaskController.createTask(
                                  context: context,
                                  title: _titleTextController.text,
                                ),
                                formKey: _formKey,
                              );
                            }
                          : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          const Icon(Icons.save),
                          const Text('Add task'),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
