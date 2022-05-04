import 'package:flutter/material.dart';
import 'package:todo/screens/archieve.dart';
import 'package:todo/screens/add_edit_category.dart';
import 'package:todo/screens/add_edit_task.dart';
import 'package:todo/screens/category_list.dart';

class Routers {
  Future<void> popDeyaled(BuildContext context, [int sec = 1]) async =>
      await Future.delayed(Duration(seconds: sec))
          .then((_) => Navigator.pop(context));

  Future<void> toCategoryPage(BuildContext context) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CategoryPage()));
  }

  Future<void> toAddEditTaskPage(
      BuildContext buildContext, int index, bool isEdit) async {
    await Navigator.of(buildContext).push(MaterialPageRoute(
        builder: (buildContext) => AddEditTaskPage(
              index: index,
              isEdit: isEdit,
            )));
  }

  Future<void> toAddEditCategoryPage(
      BuildContext context, int index, bool isEdit) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddCategoryPage(
              index: index,
              isEdit: isEdit,
            )));
  }

  Future<void> toAddArchievePage(BuildContext context) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ArchievePage()));
  }
}
