import 'package:flutter/material.dart';
import 'package:todo/widgets/task_list_page/task_body/dialog/dialogs.dart';

class ScheduleAppBarWidget extends StatelessWidget {
  const ScheduleAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Drawer icon
        IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        const Text(
          'Schredule',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        // Add button
        IconButton(
          icon: const Icon(Icons.control_point),
          color: Colors.white,
          onPressed: () => TaskListDialog().showAddDialog(context),
        ),
      ],
    );
  }
}
