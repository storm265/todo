import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDateWidget extends StatelessWidget {
  const CurrentDateWidget({
    super.key,
    required this.selectedDay,
  });

  final DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Center(
        child: 
        Text(
          '${DateFormat("MMMM").format(selectedDay)}, ${selectedDay.year}',
          style: const TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
