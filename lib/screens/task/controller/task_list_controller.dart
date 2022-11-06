import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class TaskListController extends ChangeNotifier {
  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());

  final pageController = PageController(viewportFraction: 0.18);
  List<DateTime> calendar = [];

  void generateCalendarElements() {
    calendar = List.generate(
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
    for (int i = 0; i < calendar.length; i++) {
      String selectedDayString = selectedDate.value.toString().substring(0, 11);
      String calendarList = calendar[i].toString().substring(0, 11);
      if (selectedDayString.compareTo(calendarList) == 0) {
        selectedDate.value = calendar[i];
        _scrollToElement(i);
        notifyListeners();
        break;
      }
    }
  }

  void _scrollToElement(int index) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await pageController.animateToPage(index,
          duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    });
  }

  void generateFirstCalendarElements() {
    if (pageController.position.minScrollExtent ==
        pageController.position.pixels) {
      var _firstElement = calendar.first;

      List<DateTime> _first = List.generate(
        20,
        (index) => DateTime.parse(
          DateTime.utc(_firstElement.year, _firstElement.month,
                  _firstElement.day - index)
              .toString(),
        ),
      );

      calendar.insertAll(0, _first);
    }
  }

  void generateLastCalendarElements() {
    if (pageController.position.maxScrollExtent ==
        pageController.position.pixels) {
      final _lastElement = calendar.last;

      List<DateTime> _last = List.generate(
        20,
        (index) => DateTime.parse(
          DateTime.utc(
            _lastElement.year,
            _lastElement.month,
            _lastElement.day + 1 + index,
          ).toString(),
        ),
      );

      calendar.addAll(_last);
    }
  }
}
