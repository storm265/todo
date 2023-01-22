import 'package:flutter/material.dart';
import 'package:todo/service/global_controller.dart';
import 'package:todo/screens/add_edit_task/controller/edit_controller.dart';
import 'package:todo/data/repository/category_repository.dart';
import 'package:todo/data/repository/tasks_repository.dart';
import 'package:todo/screens/add_edit_task/widgets/category_list_widget.dart';
import 'package:todo/screens/add_edit_task/widgets/textfield.dart';
import 'package:todo/screens/common_widgets/custom_app_bar_widget.dart';
import 'package:todo/screens/common_widgets/unfocus_widget.dart';

class AddEditTaskPage extends StatefulWidget {
  final int index;
  final bool isEdit;
  const AddEditTaskPage({
    Key? key,
    required this.isEdit,
    required this.index,
  }) : super(key: key);

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final _editTaskController = EditTaskController(
    categoryRepositoryImpl: CategoryRepositoryImpl(),
    tasksRepositoryImpl: TasksRepositoryImpl(),
  );

  @override
  void initState() {
    if (widget.isEdit) {
      _editTaskController.getEditData(widget.index);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        context: context,
        showActions: false,
        title: (widget.isEdit) ? 'Edit task' : 'Add task',
      ),
      body: UnfocusWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddEditTaskTextfieldWidget(
                textEditingController: addEditController.titleTextController,
                hintText: 'Text:',
                enabled: true,
              ),
              AddEditTaskTextfieldWidget(
                textEditingController: addEditController.dateTextController,
                hintText: 'Finish date:',
              ),
              OutlinedButton.icon(
                onPressed: () async => await addEditController.pickDate(
                  context: context,
                  dateTextController: addEditController.dateTextController,
                ),
                icon: const Icon(Icons.date_range_outlined),
                label: const Text('Pick date'),
              ),
              AddEditTaskTextfieldWidget(
                textEditingController: addEditController.timeTextController,
                hintText: 'Finish time:',
              ),
              OutlinedButton.icon(
                onPressed: () async => await addEditController.pickTime(
                    timeTextController: addEditController.timeTextController,
                    context: context),
                icon: const Icon(Icons.schedule_outlined),
                label: const Text('Pick time'),
              ),
              const CategoryListWidget(),
              ValueListenableBuilder<bool>(
                valueListenable: addEditController.isAddButtonActive,
                builder: (context, value, _) {
                  return OutlinedButton.icon(
                    onPressed: addEditController.isAddButtonActive.value
                        ? () {
                            addEditController.tryValidate(
                              index: widget.index,
                              isEdit: widget.isEdit,
                              context: context,
                            );
                          }
                        : null,
                    icon: Icon((widget.isEdit) ? Icons.save : Icons.add),
                    label: (widget.isEdit)
                        ? const Text('Update task')
                        : const Text('Add task'),
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
