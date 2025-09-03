import 'package:flutter/cupertino.dart';

class TaskListDialogButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressCallback;
  const TaskListDialogButton({
    super.key,
    this.icon,
    required this.onPressCallback,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressCallback,
      child: Row(
        children: [
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              if (icon != null) Icon(icon),
              Text(text),
            ],
          ),
          Spacer(),
          SizedBox()
        ],
      ),
    );
  }
}
