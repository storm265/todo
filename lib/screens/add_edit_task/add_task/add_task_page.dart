import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/data/repository/archieve/archieve_repository.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/data/repository/task/tasks_repository.dart';
import 'package:todo/screens/add_edit_task/add_task/controller/add_task_controller.dart';
import 'package:todo/screens/add_edit_task/widgets/task_editor_form.dart';
import 'package:todo/screens/widgets/gradient_appbar_widget.dart';
import 'package:todo/screens/task_list/controller/task_validator.dart';
import 'package:todo/services/common/category_index_provider.dart';
import 'package:todo/services/locator_service.dart';

@RoutePage()
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

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
  Widget build(BuildContext context) => CupertinoPageScaffold(
    navigationBar: GradientAppBarWidget(showActions: false, title: 'Add task'),
    child: TaskEditorForm(
      controller: _addTaskController,
      formKey: _formKey,
      titleController: _titleTextController,
      dateController: _dateTextController,
      isEdit: false,
      onSave: () => _addTaskController.createTask(
        context: context,
        title: _titleTextController.text,
      ),
    ),
  );
}
