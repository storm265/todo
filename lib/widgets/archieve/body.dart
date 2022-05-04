import 'package:flutter/material.dart';

class ArchieveBodyWidget extends StatelessWidget {
  final String text, category, deadlineDay, deadlineMonth, deadlineYear;
  const ArchieveBodyWidget(
      {Key? key,
      required this.category,
      required this.deadlineDay,
      required this.deadlineMonth,
      required this.deadlineYear,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 5,
        shadowColor: Colors.grey,
        child: Container(
          child: ListTile(
              title: Text(text),
              trailing: Text(category),
              subtitle: Text(
                  'Deadline at: $deadlineDay/$deadlineMonth/$deadlineYear')),
          width: 370,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
