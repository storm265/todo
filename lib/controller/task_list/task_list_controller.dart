import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class TaskListController extends ChangeNotifier {
  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
  ValueNotifier<bool> canMarkAsDone = ValueNotifier(true);
  ValueNotifier<bool> canRemove = ValueNotifier(false);
  ValueNotifier<bool> canEdit = ValueNotifier(false);
  ValueNotifier<bool> canAddToArchieve = ValueNotifier(false);

  final pageController = PageController(viewportFraction: 0.18);
  ValueNotifier<List<DateTime>> calendar = ValueNotifier([]);

  void generateCalendar() {
    calendar.value = List.generate(
        120, // 120 days = 100 days before now and 20 after now
        (index) => DateTime.parse(DateTime.utc(DateTime.now().year,
                DateTime.now().month, DateTime.now().day - 100 + index)
            .toString()));
  }

  void updateCalendar(Function update) {
    pageController.addListener(() {
      // start of the page
      if (pageController.position.minScrollExtent ==
          pageController.position.pixels) {
        print('min');

        var _firstElement = calendar.value.first;

        List<DateTime> _first = List.generate(
            20,
            (index) => DateTime.parse(DateTime.utc(_firstElement.year,
                    _firstElement.month, _firstElement.day - index)
                .toString()));

        for (int i = 0; i < _first.length; i++) {
          calendar.value.insert(0, _first[i]);
        }
          update();
      }

      // end of the page
      if (pageController.position.maxScrollExtent ==
          pageController.position.pixels) {
        print('max');

        var _lastElement = calendar.value.last;
        log(calendar.value.length.toString());
        List<DateTime> _last = List.generate(
            20,
            (index) => DateTime.parse(DateTime.utc(_lastElement.year,
                    _lastElement.month, _lastElement.day + 1 + index)
                .toString()));
        for (int i = 0; i < _last.length; i++) {
          calendar.value.add(_last[i]);
        }
       update();
      }
    });
  }

  void findIndexThenScroll() {
    for (int i = 0; i < calendar.value.length; i++) {
      String selectedDayString = selectedDate.value.toString().substring(0, 11);
      String calendarList = calendar.value[i].toString().substring(0, 11);
      if (selectedDayString.compareTo(calendarList) == 0) {
        selectedDate.value = calendar.value[i];
        _scrollToElement(i);
        notifyListeners();
        break;
      }
    }
  }

  void _scrollToElement(int index) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      pageController.animateToPage(index,
          duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    });
  }
}
