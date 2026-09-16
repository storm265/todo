import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/data/repository/archieve/archieve_repository.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/data/repository/task/tasks_repository.dart';
import 'package:todo/screens/add_edit_task/edit_task/edit_task_controller.dart';
import 'package:todo/screens/add_edit_task/widgets/task_editor_form.dart';
import 'package:todo/screens/widgets/gradient_appbar_widget.dart';
import 'package:todo/screens/task_list/controller/task_validator.dart';
import 'package:todo/services/common/category_index_provider.dart';
import 'package:todo/services/locator_service.dart';

@RoutePage()
class EditTaskPage extends StatefulWidget {
  final int taskIndex;
  final TaskModel model;

  const EditTaskPage({super.key, required this.taskIndex, required this.model});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _titleTextController = TextEditingController();
  final _dateTextController = TextEditingController();

  final _editTaskController = EditTaskController(
    archieveRepository: serviceLocator<ArchieveRepository<ArchieveModel>>(),
    categoryIndexerProvider: CategoryIndexProvider(),
    categoryRepository: serviceLocator<CategoryRepository<CategoryModel>>(),
    taskValidator: TaskValidator(),
    tasksRepository: serviceLocator<TasksRepository<TaskModel>>(),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _editTaskController.getEditData(
      index: widget.taskIndex,
      dateTextController: _dateTextController,
      titleTextController: _titleTextController,
    );

    super.initState();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _dateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    navigationBar: GradientAppBarWidget(showActions: false, title: 'Edit task'),
    child: TaskEditorForm(
      controller: _editTaskController,
      formKey: _formKey,
      titleController: _titleTextController,
      dateController: _dateTextController,
      isEdit: true,
      onSave: () => _editTaskController.updateTask(
        selectedCategory: widget.model.category,
        title: _titleTextController.text,
        index: widget.taskIndex,
        context: context,
      ),
    ),
  );
}
