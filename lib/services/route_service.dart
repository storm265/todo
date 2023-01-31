import 'package:flutter/material.dart';
import 'package:todo/data/model/tasks/task_model.dart';
import 'package:todo/screens/add_edit_task/edit_task_page/edit_task_page.dart';
import 'package:todo/screens/archieve/archieve_page.dart';
import 'package:todo/screens/add_edit_category/add_edit_category_page.dart';
import 'package:todo/screens/add_edit_task/add_task/add_task_page.dart';
import 'package:todo/screens/category/category_page.dart';

class RouteService {
  static Future<void> toCategoryPage(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CategoryPage(),
      ),
    );
  }

  static Future<void> toAddTaskPage(
    BuildContext buildContext,
  ) async {
    await Navigator.of(buildContext).push(
      MaterialPageRoute(
        builder: (buildContext) => const AddTaskPage(),
      ),
    );
  }

  static Future<void> toEditTaskPage(
    BuildContext buildContext,
    TaskModel model,
    int taskIndex,
  ) async {
    await Navigator.of(buildContext).push(
      MaterialPageRoute(
        builder: (buildContext) => EditTaskPage(
          model: model,
          taskIndex: taskIndex,
        ),
      ),
    );
  }

  static Future<void> toAddEditCategoryPage(
    BuildContext context,
    int index,
    bool isEdit,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddCategoryPage(
          index: index,
          isEdit: isEdit,
        ),
      ),
    );
  }

  static Future<void> toAddArchievePage(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ArchievePage(),
      ),
    );
  }
}
