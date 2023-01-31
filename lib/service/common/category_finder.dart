import 'package:flutter/cupertino.dart';
import 'package:todo/data/data_source/category/category_data_source_impl.dart';

import 'package:todo/data/repository/category/category_repository_impl.dart';
import 'package:todo/routes/delayed_navigator_extension.dart';
import 'package:todo/routes/routers.dart';
import 'package:todo/screens/common_widgets/custom_snackbar_widget.dart';

// TODO remove it
class CategoryFinder {
  final _categoryIsNotEmpty =
      CategoryRepositoryImpl(categoryDataSource: CategoryDataSourceImpl())
          .getDatabase()
          .isNotEmpty;
  void checkCategoryIsNotEmpty(BuildContext context, int i) async {
    if (_categoryIsNotEmpty) {
      await Routers.toAddEditTaskPage(context, i, true);
    } else {
      CustomSnackbarWidget.showCustomSnackbar(
        context: context,
        message: 'No categories! Add category at first!',
      );
    }
  }

  void checkCategoryIsNotEmptyDialog(BuildContext context) {
    if (_categoryIsNotEmpty) {
      DelayedNavigator.delayedPush(context,
          () async => await Routers.toAddEditTaskPage(context, 0, false));
    } else {
      CustomSnackbarWidget.showCustomSnackbar(
        context: context,
        message: 'No categories! Add category at first!',
      );
    }
  }
}
