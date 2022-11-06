import 'package:flutter/material.dart';
import 'package:todo/screens/archieve/archieve_page.dart';
import 'package:todo/screens/add_edit_category/add_edit_category_page.dart';
import 'package:todo/screens/add_edit_task/add_edit_task_page.dart';
import 'package:todo/screens/category/category_page.dart';

class Routers {

  static Future<void> toCategoryPage(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CategoryPage(),
      ),
    );
  }

  static Future<void> toAddEditTaskPage(
    BuildContext buildContext,
    int index,
    bool isEdit,
  ) async {
    await Navigator.of(buildContext).push(
      MaterialPageRoute(
        builder: (buildContext) =>
            AddEditTaskPage(index: index, isEdit: isEdit),
      ),
    );
  }

  static Future<void> toAddEditCategoryPage(
      BuildContext context, int index, bool isEdit) async {
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
