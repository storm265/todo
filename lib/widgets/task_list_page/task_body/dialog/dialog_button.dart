import 'package:flutter/material.dart';

class TaskListDialogButton extends StatelessWidget {
 final String text;
  final IconData icon;
  final VoidCallback method;
  const TaskListDialogButton(
      {Key? key, required this.icon, required this.method, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        label: Text(text), icon: Icon(icon), onPressed: method);
  }
}
