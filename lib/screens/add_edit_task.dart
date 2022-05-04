import 'package:flutter/material.dart';
import 'package:todo/controller/add_edit_task_controller/edit_controller.dart';
import 'package:todo/controller/global_variables.dart';
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
    super.initState();

    if (widget.isEdit) {
      EditTaskController().getEditData(widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBarWidget(
          buildContext: context,
          showActions: false,
          title: (widget.isEdit) ? 'Edit task' : 'Add task',
        ),
        body: SingleChildScrollView(
          child: Builder(builder: (context) {
            return Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                AddEditTaskTextfieldWidget().textField(
                    addEditCtller.titleTextController, 'Text:', true),
                AddEditTaskTextfieldWidget().textField(
                    addEditCtller.dateTextController, 'Deadline date:'),
                OutlinedButton.icon(
                    onPressed: () => addEditCtller.pickDate(
                          context: context,
                          dateTextController: addEditCtller.dateTextController,
                        ),
                    icon: const Icon(
                      Icons.date_range_outlined,
                    ),
                    label: const Text('Pick date')),
                AddEditTaskTextfieldWidget().textField(
                    addEditCtller.timeTextController, 'Deadline time:'),
                OutlinedButton.icon(
                    onPressed: () => addEditCtller.pickTime(
                        timeTextController: addEditCtller.timeTextController,
                        buildContext: context),
                    icon: const Icon(
                      Icons.schedule_outlined,
                    ),
                    label: const Text('Pick time')),
                const CategoryListWidget(),
                ValueListenableBuilder(
                  valueListenable: addEditCtller.isButtonDisabled,
                  builder: (context, value, _) {
                    return OutlinedButton.icon(
                        onPressed: addEditCtller.isButtonDisabled.value
                            ? null
                            : () {
                                addEditCtller.validate(
                                    index: widget.index,
                                    isEdit: widget.isEdit,
                                    context: context);
                              },
                        icon: Icon((widget.isEdit) ? Icons.save : Icons.add),
                        label: (widget.isEdit)
                            ? const Text('Update task')
                            : const Text('Add task'));
                  },
                ),
              ],
            );
          }),
        ));
  }
}
