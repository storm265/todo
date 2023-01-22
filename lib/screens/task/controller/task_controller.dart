// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:todo/service/close_keyboard.dart';
import 'package:todo/service/common/category_index_provider.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/data/repository/archieve_repository.dart';
import 'package:todo/data/repository/category_repository.dart';
import 'package:todo/data/repository/tasks_repository.dart';
import 'package:todo/screens/common_widgets/custom_snackbar_widget.dart';

class AddEditTaskController extends ChangeNotifier {
  final TasksRepositoryImpl _tasksRepository;

  final CategoryIndexProvider _categoryIndexerProvider;

  AddEditTaskController({
    required TasksRepositoryImpl tasksRepository,
    required CategoryIndexProvider categoryIndexerProvider,
    required ArchieveRepositoryImpl archieveRepository,
  })  : _tasksRepository = tasksRepository,
        _categoryIndexerProvider = categoryIndexerProvider;

  final titleTextController = TextEditingController();
  final dateTextController = TextEditingController();
  final timeTextController = TextEditingController();

  final isAddButtonActive = ValueNotifier<bool>(true);

  final selectedCategory = ValueNotifier<int>(0);
  final _categoryBox = CategoryRepositoryImpl().database;

  DateTime? convertedDateTime;
  final pickedDate = ValueNotifier<DateTime?>(DateTime.now());
  final pickedTime =
      ValueNotifier<TimeOfDay?>(const TimeOfDay(hour: 1, minute: 11));

  bool get _isTextValid => titleTextController.text.length < 4;
  bool get _isDatePicked => dateTextController.value.text.isEmpty;
  bool get _isTimePicked => timeTextController.value.text.isEmpty;

  Future<void> changeIsDisabledButton(bool newValue) async {
    if (newValue) {
      await Future.delayed(const Duration(seconds: 1));
    }
    isAddButtonActive.value = newValue;
  }

  Future<void> tryValidate({
    required BuildContext context,
    required int index,
    required bool isEdit,
  }) async {
    await changeIsDisabledButton(false);
    convertedDateTime = DateTime.utc(
      pickedDate.value!.year,
      pickedDate.value!.month,
      pickedDate.value!.day,
      pickedTime.value!.hour,
      pickedTime.value!.minute,
    );
    if (_isTextValid) {
      showMessage(context, 'Text title must be more then 4 characters. 😑');
    } else if (_isDatePicked) {
      showMessage(context, 'Pick date. 😑');
    } else if (_isTimePicked) {
      showMessage(context, 'Pick time. 😑');
    } else if (DateTime.now().isBefore(convertedDateTime!)) {
      if (isEdit) {
        await editData(
            context: context,
            selectedCategory: _categoryBox.getAt(selectedCategory.value)!.title,
            index: index);
      } else {
        await saveData(
            context: context,
            selectedCategory:
                _categoryBox.getAt(selectedCategory.value)!.title);
      }
    } else {
      showMessage(context, 'You cant create task is past!');
    }
    await changeIsDisabledButton(true);
  }

  Future<void> saveData({
    required String selectedCategory,
    required BuildContext context,
  }) async {
    await _tasksRepository
        .saveTask(
          TaskModel(
            id: _categoryIndexerProvider.getCategoryIndex(selectedCategory),
            isDone: false,
            category: selectedCategory,
            creationDate: DateTime.now(),
            text: titleTextController.text,
            deadlineDateTime: convertedDateTime!,
          ),
        )
        .then((_) => showMessage(context, 'Task added😊 🚀.'));

    cleanFields();
    Navigator.pop(context);
  }

  Future<void> editData({
    required String selectedCategory,
    required int index,
    required BuildContext context,
  }) async {
    await _tasksRepository.database
        .putAt(
          index,
          TaskModel(
            id: _categoryIndexerProvider.getCategoryIndex(selectedCategory),
            isDone: false,
            category: selectedCategory,
            creationDate: DateTime.now(),
            text: titleTextController.text,
            deadlineDateTime: convertedDateTime!,
          ),
        )
        .then(
          (_) => showMessage(context, 'Task updated 😊 🚀.'),
        );

    cleanFields();
    Navigator.pop(context);
  }

  void cleanFields() {
    titleTextController.clear();
    dateTextController.clear();
    timeTextController.clear();
    selectedCategory.value = 0;
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
