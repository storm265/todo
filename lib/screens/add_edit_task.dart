import 'package:flutter/material.dart';
import 'package:todo/controller/global_controller.dart';
import 'package:todo/controller/task_controller/edit_controller.dart';
import 'package:todo/main.dart';
import 'package:todo/widgets/add_edit_task/category_list_widget.dart';
import 'package:todo/widgets/add_edit_task/textfield.dart';
import 'package:todo/widgets/common/custom_app_bar_widget.dart';

class AddEditTaskPage extends StatefulWidget {
  final int index;
  final bool isEdit;
  const AddEditTaskPage({Key? key, required this.isEdit, required this.index})
      : super(key: key);

  @override
  _AddEditTaskPageState createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  @override
  void initState() {
    if (widget.isEdit) {
      EditTaskController().getEditData(widget.index);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBarWidget(
          context: context,
          showActions: false,
          title: (widget.isEdit) ? 'Edit task' : 'Add task'),
      body: UnfocusWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              AddEditTaskTextfieldWidget(
                textEditingController: addEditController.titleTextController,
                hintText: 'Text:',
                enabled: true,
              ),
              AddEditTaskTextfieldWidget(
                textEditingController: addEditController.dateTextController,
                hintText: 'Deadline date:',
              ),
              OutlinedButton.icon(
                onPressed: () => addEditController.pickDate(
                  context: context,
                  dateTextController: addEditController.dateTextController,
                ),
                icon: const Icon(Icons.date_range_outlined),
                label: const Text('Pick date'),
              ),
              AddEditTaskTextfieldWidget(
                textEditingController: addEditController.timeTextController,
                hintText: 'Deadline time:',
              ),
              OutlinedButton.icon(
                onPressed: () => addEditController.pickTime(
                    timeTextController: addEditController.timeTextController,
                    context: context),
                icon: const Icon(Icons.schedule_outlined),
                label: const Text('Pick time'),
              ),
              const CategoryListWidget(),
              ValueListenableBuilder<bool>(
                valueListenable: addEditController.isButtonDisabled,
                builder: (context, value, _) {
                  return OutlinedButton.icon(
                    onPressed: addEditController.isButtonDisabled.value
                        ? null
                        : () {
                            addEditController.validate(
                                index: widget.index,
                                isEdit: widget.isEdit,
                                context: context);
                          },
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
