import 'package:flutter/cupertino.dart';
import 'package:todo/screens/add_edit_task/add_task/widgets/category_list_widget.dart';
import 'package:todo/screens/add_edit_task/add_task/widgets/textfield_widget.dart';
import 'package:todo/screens/task_list/controller/task_controller.dart';
import 'package:todo/screens/widgets/unfocus_widget.dart';
import 'package:todo/utils/theme_extension.dart';

class TaskEditorForm extends StatelessWidget {
  const TaskEditorForm({
    super.key,
    required this.controller,
    required this.formKey,
    required this.titleController,
    required this.dateController,
    required this.onSave,
    this.isEdit = false,
  });
  final TaskController controller;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController dateController;
  final Future<void> Function() onSave;
  final bool isEdit;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsetsGeometry.only(
      top: MediaQuery.paddingOf(context).top,
      bottom: MediaQuery.paddingOf(context).bottom,
    ),
    child: UnfocusWidget(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEdit ? 'Refine your plan' : 'Make time for it',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Give your task a name, a date and a category.',
                      style: TextStyle(
                        color: context.secondaryTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              TextfieldWidget(
                textEditingController: titleController,
                hintText: 'What needs to be done?',
                enabled: true,
                validator: (value) =>
                    controller.taskValidator.isTitleValid(text: value),
              ),
              TextfieldWidget(
                textEditingController: dateController,
                hintText: 'Date and time',
                validator: (value) =>
                    controller.taskValidator.isDateValid(text: value),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CupertinoButton(
                  onPressed: () => controller.pickDate(
                    context: context,
                    dateTextController: dateController,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.calendar, size: 20),
                      SizedBox(width: 8),
                      Text('Choose date and time'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                child: Text(
                  'CATEGORY',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    color: context.secondaryTextColor,
                  ),
                ),
              ),
              CategoryListWidget(taskController: controller),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: controller.isSubmitActive,
                    builder: (context, active, _) => CupertinoButton.filled(
                      borderRadius: BorderRadius.circular(18),
                      onPressed: active
                          ? () => controller.validateForm(
                              context: context,
                              callback: onSave,
                              formKey: formKey,
                            )
                          : null,
                      child: Text(
                        isEdit ? 'Save changes' : 'Create task',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
