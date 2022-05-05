import 'package:flutter/cupertino.dart';

import 'package:todo/repository/category_repository.dart';
import 'package:todo/controller/task_list/dialog_close_controller.dart';
import 'package:todo/routes/routers.dart';
import 'package:todo/widgets/common/custom_snackbar_widget.dart';

class SameCategoryFinder {
  final _snackBar = CustomSnackbarWidget();
  final _categoryIsNotEmpty = CategoryRepository().getDatabase().isNotEmpty;
  void checkCategoryIsNotEmpty(BuildContext context, int i) {
    if (_categoryIsNotEmpty) {
      Routers().toAddEditTaskPage(context, i, true);
    } else {
      _snackBar.showCustomSnackbar(
        context: 
        context,
     message:    'No categories! Add category at first!',
      );
    }
  }

  void checkCategoryIsNotEmptyDialog(BuildContext context) {
    if (_categoryIsNotEmpty) {
      DialogDelayedWrapper().delayedPush(
        context,
        () => Routers().toAddEditTaskPage(context, 0, false),
      );
    } else {
      _snackBar.showCustomSnackbar(
        context: 
        context,
      message:   'No categories! Add category at first!',
      );
    }
  }
}
