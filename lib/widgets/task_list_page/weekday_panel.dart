import 'package:flutter/material.dart';

import 'package:todo/widgets/task_list_page/popup_menu.dart';

class WeekDayPanelWidget extends StatefulWidget {
  final DateTime selectedDay;
  const WeekDayPanelWidget({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  @override
  State<WeekDayPanelWidget> createState() => _WeekDayPanelWidgetState();
}

class _WeekDayPanelWidgetState extends State<WeekDayPanelWidget> {
  @override
  Widget build(BuildContext context) {
    int day = widget.selectedDay.day;
    int month = widget.selectedDay.month;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(14),
          child: Text(
            (widget.selectedDay.day == (DateTime.now().day))
                ? 'Today'
                : (day.toString().length == 1)
                    ? '0$day/$month'
                    : '$day/$month',
            style: const TextStyle(
                fontSize: 35,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
        ),
        PopupMenuWidget()
      ],
    );
  }
}
