import 'package:flutter/cupertino.dart';

import 'package:todo/data/repository/category_repository.dart';
import 'package:todo/routes/delayed_navigator_extension.dart';
import 'package:todo/routes/routers.dart';
import 'package:todo/widgets/common/custom_snackbar_widget.dart';

class SameCategoryFinder {
  final _categoryIsNotEmpty = CategoryRepositoryImpl().database.isNotEmpty;
  void checkCategoryIsNotEmpty(BuildContext context, int i) {
    if (_categoryIsNotEmpty) {
      Routers.toAddEditTaskPage(context, i, true);
    } else {
      CustomSnackbarWidget.showCustomSnackbar(
          context: context, message: 'No categories! Add category at first!');
    }
  }

  void checkCategoryIsNotEmptyDialog(BuildContext context) {
    if (_categoryIsNotEmpty) {
      DelayedNavigator.delayedPush(
          context, () => Routers.toAddEditTaskPage(context, 0, false));
    } else {
      CustomSnackbarWidget.showCustomSnackbar(
          context: context, message: 'No categories! Add category at first!');
    }
  }
}
