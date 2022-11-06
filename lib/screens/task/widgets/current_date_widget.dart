import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDateWidget extends StatelessWidget {
  final DateTime selectedDay;
  const CurrentDateWidget({Key? key, required this.selectedDay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          '${DateFormat("MMMM").format(selectedDay)}, ${selectedDay.year}',
          style: const TextStyle(fontSize: 23, color: Colors.white),
        ),
      ),
    );
  }
}
