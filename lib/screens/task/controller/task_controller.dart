// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo/utils/future_type.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/screens/task/controller/task_validator.dart';
import 'package:todo/services/common/close_keyboard.dart';
import 'package:todo/services/common/category_index_provider.dart';
import 'package:todo/data/repository/archieve/archieve_repository.dart';
import 'package:todo/data/repository/task/tasks_repository.dart';
import 'package:todo/screens/widgets/custom_snackbar_widget.dart';

class TaskController extends ChangeNotifier {
  final TaskValidator taskValidator;
  final TasksRepository tasksRepository;

  final CategoryIndexProvider categoryIndexerProvider;
  final CategoryRepository categoryRepository;

  TaskController({
    required this.taskValidator,
    required this.tasksRepository,
    required this.categoryIndexerProvider,
    required ArchieveRepository archieveRepository,
    required this.categoryRepository,
  });

  final isSubmitActive = ValueNotifier<bool>(true);

  final selectedCategoryIndex = ValueNotifier<int>(0);

  Box<CategoryModel> getCategoryBox() => categoryRepository.getDatabase();
  DateTime? convertedDateTime;
  final pickedDate = ValueNotifier<DateTime?>(DateTime.now());
  final pickedTime =
      ValueNotifier<TimeOfDay?>(const TimeOfDay(hour: 1, minute: 11));

  Future<void> changeIsDisabledButton(bool newValue) async {
    if (newValue) {
      await Future.delayed(const Duration(seconds: 1));
    }
    isSubmitActive.value = newValue;
  }

  Future<void> validateForm({
    required BuildContext context,
    required FutureCallback callback,
    required GlobalKey<FormState> formKey,
  }) async {
    await changeIsDisabledButton(false);
    if (formKey.currentState!.validate()) {
      convertedDateTime = DateTime.utc(
        pickedDate.value!.year,
        pickedDate.value!.month,
        pickedDate.value!.day,
        pickedTime.value!.hour,
        pickedTime.value!.minute,
      );
      if (taskValidator.isNowBeforePast(pickedDate: convertedDateTime!)) {
        await callback();
        Navigator.pop(context);
      } else {
        showMessage(context, 'You cant create task is past!');
      }
    }
    await changeIsDisabledButton(true);
  }

  Future<void> pickTime({
    required BuildContext context,
    required TextEditingController timeTextController,
  }) async {
    closeKeyboard(context);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: TimeOfDay.now().hour,
        minute: TimeOfDay.now().minute + 2,
      ),
    );

    pickedTime.value = picked!;

    if (pickedTime.value != null) {
      timeTextController.text = DateFormat('hh:mm a').format(DateTime.utc(
          2022, 12, 12, pickedTime.value!.hour, pickedTime.value!.minute));
    }
  }

  Future<void> pickDate({
    required TextEditingController dateTextController,
    required BuildContext context,
  }) async {
    closeKeyboard(context);

    final DateTime? picked = await showPlatformDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 50),
    );

    pickedDate.value = picked;

    if (pickedDate.value != null) {
      dateTextController.text = DateFormat.yMd().format(pickedDate.value!);
    }
  }

  void showMessage(
    BuildContext context,
    String message,
  ) =>
      CustomSnackbarWidget.showCustomSnackbar(
        context: context,
        message: message,
      );
}
