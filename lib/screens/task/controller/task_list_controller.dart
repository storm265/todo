import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/data/repository/archieve/archieve_repository.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/data/repository/task/tasks_repository.dart';
import 'package:todo/screens/common_widgets/custom_snackbar_widget.dart';
import 'package:todo/service/common/category_index_provider.dart';

class TaskListController {
  final CategoryIndexProvider _categoryIndexProvider;
  final TasksRepository _taskRepository;
  final ArchieveRepository archieveRepository;
  final CategoryRepository _categoryRepository;

  TaskListController({
    required CategoryRepository categoryRepository,
    required TasksRepository taskRepository,
    required CategoryIndexProvider categoryIndexProvider,
    required this.archieveRepository,
  })  : _taskRepository = taskRepository,
        _categoryIndexProvider = categoryIndexProvider,
        _categoryRepository = categoryRepository;

  Box<TaskModel> getTaskDataBase() => _taskRepository.getDatabase();

  final selectedDate = ValueNotifier(DateTime.now());

  final pageController = PageController(viewportFraction: 0.18);
  final calendar = ValueNotifier<List<DateTime>>([]);

  Future<void> markTaskAsDone({
    required TaskModel task,
    required int index,
  }) async {
    await getTaskDataBase().putAt(
      index,
      TaskModel(
        id: _categoryIndexProvider.getCategoryIndex(task.category),
        creationDate: task.creationDate,
        deadlineDateTime: task.deadlineDateTime,
        text: task.text,
        category: task.category,
        isDone: true,
      ),
    );
  }

  Future<void> pushTaskToArchieve({required TaskModel task}) async =>
      await archieveRepository.save(
        ArchieveModel(
          category: task.category,
          text: task.text,
          deadlineDateTime: task.deadlineDateTime,
        ),
      );

  Future<void> deleteTask({required int index}) async =>
      await _taskRepository.deleteTask(index);

  void generateCalendarElements() {
    calendar.value = List.generate(
      120, // 120 days = 100 days before now and 20 after now
      (index) => DateTime.parse(
        DateTime.utc(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day - 100 + index,
        ).toString(),
      ),
    );
  }

  void updateCalendarElements(Function callback) {
    pageController.addListener(() {
      generateLastCalendarElements();
      generateFirstCalendarElements();
      callback();
    });
  }

  void scrollToSelectedIndex() {
    for (int i = 0; i < calendar.value.length; i++) {
      String selectedDayString = DateFormat.yMd().format(selectedDate.value);
      String calendarList = DateFormat.yMd().format(calendar.value[i]);
      if (selectedDayString == calendarList) {
        selectedDate.value = calendar.value[i];

        _scrollToElement(i);

        break;
      }
    }
  }

  void _scrollToElement(int index) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await pageController.animateToPage(
        index,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  void generateFirstCalendarElements() {
    if (pageController.position.minScrollExtent ==
        pageController.position.pixels) {
      final firstElement = calendar.value.first;

      List<DateTime> first = List.generate(
        20,
        (index) => DateTime.parse(
          DateTime.utc(firstElement.year, firstElement.month,
                  firstElement.day - index)
              .toString(),
        ),
      );

      calendar.value.insertAll(0, first);
    }
  }

  void generateLastCalendarElements() {
    if (pageController.position.maxScrollExtent ==
        pageController.position.pixels) {
      final lastElement = calendar.value.last;

      List<DateTime> last = List.generate(
        20,
        (index) => DateTime.parse(
          DateTime.utc(
            lastElement.year,
            lastElement.month,
            lastElement.day + 1 + index,
          ).toString(),
        ),
      );

      calendar.value.addAll(last);
    }
  }

  bool isNotEmptyCategory(BuildContext context) {
    if (_categoryRepository.getDatabase().isNotEmpty) {
      return true;
    } else {
      CustomSnackbarWidget.showCustomSnackbar(
        context: context,
        message: 'No categories! Add category at first!',
      );
      return false;
    }
  }
}
