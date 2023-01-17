import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:todo/controller/close_keyboard.dart';
import 'package:todo/controller/common/category_index_provider.dart';
import 'package:todo/controller/common/string_time_formatter.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/data/repository/archieve_repository.dart';

import 'package:todo/data/repository/category_repository.dart';
import 'package:todo/data/repository/tasks_repository.dart';
import 'package:todo/screens/common_widgets/custom_snackbar_widget.dart';

class TaskValidator {}

class AddEditTaskController extends ChangeNotifier {
  final TasksRepositoryImpl _tasksRepository;
  final StringTimeFormatter _stringTimeFormatter;
  final CategoryIndexProvider _categoryIndexerProvider;
  final ArchieveRepositoryImpl _archieveRepository;

  AddEditTaskController({
    required TasksRepositoryImpl tasksRepository,
    required StringTimeFormatter stringTimeFormatter,
    required CategoryIndexProvider categoryIndexerProvider,
    required ArchieveRepositoryImpl archieveRepository,
  })  : _tasksRepository = tasksRepository,
        _stringTimeFormatter = stringTimeFormatter,
        _categoryIndexerProvider = categoryIndexerProvider,
        _archieveRepository = archieveRepository;

  final titleTextController = TextEditingController();
  final dateTextController = TextEditingController();
  final timeTextController = TextEditingController();

  final isAddButtonActive = ValueNotifier<bool>(true);

  final selectedCategory = ValueNotifier<int>(0);
  final _categoryBox = CategoryRepositoryImpl().database;

  final stringDate = ValueNotifier<String>('');
  String convertedDateTime = '';
  final pickedDate = ValueNotifier<DateTime?>(DateTime.now());
  final pickedTime =
      ValueNotifier<TimeOfDay?>(const TimeOfDay(hour: 1, minute: 11));

  String? hour, min;

  bool get _isTextValid => titleTextController.text.length < 4;
  bool get _isDatePicked => dateTextController.value.text.isEmpty;
  bool get _isTimePicked => timeTextController.value.text.isEmpty;

  void changeIsDisabledButton(bool newValue) {
    isAddButtonActive.value = newValue;
    isAddButtonActive.notifyListeners();
  }

  Future<void> tryValidate({
    required BuildContext context,
    required int index,
    required bool isEdit,
  }) async {
    convertedDateTime = '${stringDate.value} $hour:$min:00.000000';

    if (_isTextValid) {
      showMessage(context, 'Text title must be more then 4 characters. 😑');
    } else if (_isDatePicked) {
      showMessage(context, 'Pick date. 😑');
    } else if (_isTimePicked) {
      showMessage(context, 'Pick time. 😑');
    } else if (DateTime.now().isBefore(DateTime.parse(convertedDateTime))) {
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
  }

  Future<void> saveData({
    required String selectedCategory,
    required BuildContext context,
  }) async {
    changeIsDisabledButton(false);
    await _tasksRepository.save(
      TaskModel(
        id: _categoryIndexerProvider.getCategoryIndex(selectedCategory),
        isDone: false,
        category: selectedCategory,
        creationDate: DateTime.now(),
        text: titleTextController.text,
        deadlineDateTime: DateTime.parse(convertedDateTime),
      ),
    );

    changeIsDisabledButton(true);
    showMessage(context, 'Task added😊 🚀.');
    cleanFields();
    Navigator.pop(context);
  }

  Future<void> addToArchieve({
    required String selectedCategory,
    required BuildContext context,
  }) async =>
      await _archieveRepository.save(
        ArchieveModel(
          category: selectedCategory,
          text: titleTextController.text,
          deadlineDateTime: DateTime.parse(convertedDateTime),
        ),
      );

  Future<void> editData({
    required String selectedCategory,
    required int index,
    required BuildContext context,
  }) async {
    changeIsDisabledButton(false);
    await _tasksRepository.database
        .putAt(
          index,
          TaskModel(
            id: _categoryIndexerProvider.getCategoryIndex(selectedCategory),
            isDone: false,
            category: selectedCategory,
            creationDate: DateTime.now(),
            text: titleTextController.text,
            deadlineDateTime: DateTime.parse(convertedDateTime),
          ),
        )
        .then(
          (_) => showMessage(context, 'Task updated 😊 🚀.'),
        );

    changeIsDisabledButton(true);
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
      hour = _stringTimeFormatter.formatTime(pickedTime.value!.hour);
      min = _stringTimeFormatter.formatTime(pickedTime.value!.minute);
      timeTextController.text = '$hour:$min';
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
      String month = _stringTimeFormatter.formatTime(pickedDate.value!.month);
      String day = _stringTimeFormatter.formatTime(pickedDate.value!.day);
      stringDate.value = '${pickedDate.value!.year}-$month-$day';
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
