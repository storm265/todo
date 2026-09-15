// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/utils/future_type.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/screens/task_list/controller/task_validator.dart';
import 'package:todo/services/common/close_keyboard.dart';
import 'package:todo/services/common/category_index_provider.dart';
import 'package:todo/data/repository/archieve/archieve_repository.dart';
import 'package:todo/data/repository/task/tasks_repository.dart';

class TaskController extends ChangeNotifier {
  final TaskValidator taskValidator;
  final TasksRepository tasksRepository;

  final CategoryIndexProvider categoryIndexerProvider;
  final CategoryRepository<CategoryModel> categoryRepository;

  TaskController({
    required this.taskValidator,
    required this.tasksRepository,
    required this.categoryIndexerProvider,
    required ArchieveRepository<ArchieveModel> archieveRepository,
    required this.categoryRepository,
  });

  final isSubmitActive = ValueNotifier<bool>(true);

  final selectedCategoryIndex = ValueNotifier<int>(0);

  Box<CategoryModel> getCategoryBox() => categoryRepository.getDatabase();
  DateTime? convertedDateTime;
  final pickedDate = ValueNotifier<DateTime?>(DateTime.now());

  Future<void> validateForm({
    required BuildContext context,
    required FutureCallback callback,
    required GlobalKey<FormState> formKey,
  }) async {
    try {
      isSubmitActive.value = false;
      if (formKey.currentState!.validate()) {
        convertedDateTime = DateTime.utc(
          pickedDate.value!.year,
          pickedDate.value!.month,
          pickedDate.value!.day,
          pickedDate.value!.hour,
          pickedDate.value!.minute,
        );
        if (taskValidator.isNowBeforePast(pickedDate: convertedDateTime!)) {
          await callback();
          Navigator.pop(context);
        } else {
          //  showMessage(context, 'You cant create task is past!');
        }
      }
    } catch (e) {
      isSubmitActive.value = true;
    } finally {
      isSubmitActive.value = true;
    }
  }

  Future<void> pickDate({
    required TextEditingController dateTextController,
    required BuildContext context,
  }) async {
    closeKeyboard(context);

    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          top: false,
          child: StatefulBuilder(
            builder: (context, setState) => CupertinoDatePicker(
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() => pickedDate.value = newDateTime);
              },
            ),
          ),
        ),
      ),
    );

    if (pickedDate.value != null) {
      dateTextController.text =
          DateFormat('dd:mm:yyy hh:mm a').format(pickedDate.value!);
    }
  }
}
