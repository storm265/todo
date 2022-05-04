import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:todo/controller/common/category_index_controller.dart';
import 'package:todo/controller/common/string_time_formatter.dart';
import 'package:todo/model/archieve_db/archieve_db.dart';
import 'package:todo/model/tasks_db/task_model.dart';
import 'package:todo/repository/archieve_repository.dart';
import 'package:todo/repository/category_repository.dart';
import 'package:todo/repository/repository.dart';
import 'package:todo/repository/tasks_repository.dart';
import 'package:todo/routes/my_routes.dart';
import 'package:todo/widgets/common/custom_snackbar_widget.dart';

// reduce if else
// use String interpolation
// try reduce context by observer
class AddEditTaskController {
  var titleTextController = TextEditingController();
  var dateTextController = TextEditingController();
  var timeTextController = TextEditingController();

  var isButtonDisabled = ValueNotifier<bool>(false);
  var selectedCategory = ValueNotifier<int>(0);

  var stringDate = ValueNotifier<String>('');
  var convertedDateTime = ValueNotifier<String>('');
  var pickedDate = ValueNotifier<DateTime>(DateTime.now());
  var pickedTime =
      ValueNotifier<TimeOfDay>(const TimeOfDay(hour: 1, minute: 11));

  final _formatter = StringTimeFormatter();

  late Repository repository;
  final _categoryIndexer = CategoryIndexController();
  String? hour, min;

  AddEditTaskController() {
    repository = ArchieveRepository();
  }

  bool get isTextValid => titleTextController.text.length < 4;
  bool get isDatePicked => dateTextController.value.text.isEmpty;
  bool get isTimePicked => timeTextController.value.text.isEmpty;

  Future<void> validate(
      {required BuildContext context,
      required int index,
      required bool isEdit}) async {
    try {
      convertedDateTime.value = '${stringDate.value} $hour:$min:00.000000';

      if (isTextValid) {
        showMessage(context, 'Text title must be more then 4 characters. 😑');
      } else if (isDatePicked) {
        showMessage(context, 'Pick date. 😑');
      } else if (isTimePicked) {
        showMessage(context, 'Pick time. 😑');
      } else if (DateTime.now()
          .isBefore(DateTime.parse(convertedDateTime.value))) {
        if (isEdit) {
          await editData(
              context: context,
              selectedCategory: CategoryRepository()
                  .getDatabase()
                  .getAt(selectedCategory.value)!
                  .title,
              index: index);
        } else {
          await saveData(
              context: context,
              selectedCategory: CategoryRepository()
                  .getDatabase()
                  .getAt(selectedCategory.value)!
                  .title);
        }
      } else {
        showMessage(context, 'You cant create task is past!');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return Future.value();
  }

  Future<void> saveData(
      {required String selectedCategory, required BuildContext context}) async {
    try {
      repository = TasksRepository();
      for (int i = 0; i < 10; i++) {
        await repository.save(TaskModel(
          id: _categoryIndexer.getCategoryIndex(selectedCategory),
          isDone: false,
          category: selectedCategory,
          creationDate: DateTime.now(),
          text: titleTextController.text + "$i",
          deadlineDateTime: DateTime.parse(convertedDateTime.value),
        ));
      }
    } catch (e) {
      debugPrint('Null exception in _saveData()!');
      showMessage(context, '$e');
    }
    isButtonDisabled.value = true;
    showMessage(context, 'Task added😊 🚀.');
    cleanFields();
    await Routers().popDeyaled(context);
    isButtonDisabled.value = false;
  }

  Future<void> addToArchieve(
      {required String selectedCategory, required BuildContext context}) async {
    try {
      await ArchieveRepository().save(ArchieveModel(
        category: selectedCategory,
        text: titleTextController.text,
        deadlineDateTime: DateTime.parse(convertedDateTime.value),
      ));
    } on Exception {
      debugPrint('Null exception in _saveData()!');
    }
  }

  Future<void> editData(
      {required String selectedCategory,
      required int index,
      required BuildContext context}) async {
    try {
      await TasksRepository().getDatabase().putAt(
          index,
          TaskModel(
            id: _categoryIndexer.getCategoryIndex(selectedCategory),
            isDone: false,
            category: selectedCategory,
            creationDate: DateTime.now(),
            text: titleTextController.text,
            deadlineDateTime: DateTime.parse(convertedDateTime.value),
          ));
    } on Exception {
      debugPrint('Null exception in _editData()!');
    }
    isButtonDisabled.value = true;
    showMessage(context, 'Task updated 😊 🚀.');
    cleanFields();
    await Routers().popDeyaled(context);
    isButtonDisabled.value = false;
  }

  void cleanFields() {
    titleTextController.clear();
    dateTextController.clear();
    timeTextController.clear();
    selectedCategory.value = 0;
  }

  Future<void> pickTime(
      {required BuildContext buildContext,
      required TextEditingController timeTextController}) async {
    try {
      unFocusTextField(buildContext);
      final TimeOfDay? picked = await showTimePicker(
          builder: (BuildContext buildContext, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(buildContext)
                  .copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
          context: buildContext,
          initialTime: TimeOfDay(
              hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute));

      pickedTime.value = picked!;

      hour = _formatter.formatTime(pickedTime.value.hour);
      min = _formatter.formatTime(pickedTime.value.minute);

      timeTextController.text = '$hour:$min';
    } on Exception {
      debugPrint('Null exception in pickTime()!');
    }
  }

  Future<void> pickDate(
      {required TextEditingController dateTextController,
      required BuildContext context}) async {
    try {
      unFocusTextField(context);
      final DateTime picked = (await showPlatformDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 2),
      ))!;

      pickedDate.value = picked;

      dateTextController.text = DateFormat.yMd().format(pickedDate.value);
      String _month = _formatter.formatTime(pickedDate.value.month);
      String _day = _formatter.formatTime(pickedDate.value.day);
      stringDate.value = '${pickedDate.value.year}-$_month-$_day';
    } on Exception {
      debugPrint('Null exception in pickTime()!');
    }
  }

  void unFocusTextField(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void showMessage(BuildContext context, String message) =>
      CustomSnackbarWidget().showCustomSnackbar(context, message);
}
