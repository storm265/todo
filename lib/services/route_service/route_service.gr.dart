// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/cupertino.dart' as _i11;
import 'package:todo/data/model/tasks/task_model.dart' as _i12;
import 'package:todo/screens/add_edit_category/add_edit_category_page.dart'
    as _i1;
import 'package:todo/screens/add_edit_task/add_task/add_task_page.dart' as _i2;
import 'package:todo/screens/add_edit_task/edit_task/edit_task_page.dart'
    as _i5;
import 'package:todo/screens/archieve/archieve_page.dart' as _i3;
import 'package:todo/screens/category/category_page.dart' as _i4;
import 'package:todo/screens/initial_screen/initial_screen.dart' as _i6;
import 'package:todo/screens/settings/pick_gradient/pick_gradient_screen.dart'
    as _i7;
import 'package:todo/screens/settings/settings_page.dart' as _i8;
import 'package:todo/screens/task_list/task_list_page.dart' as _i9;

/// generated route for
/// [_i1.AddCategoryPage]
class AddCategoryRoute extends _i10.PageRouteInfo<AddCategoryRouteArgs> {
  AddCategoryRoute({
    _i11.Key? key,
    required int index,
    required bool isEdit,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          AddCategoryRoute.name,
          args: AddCategoryRouteArgs(
            key: key,
            index: index,
            isEdit: isEdit,
          ),
          initialChildren: children,
        );

  static const String name = 'AddCategoryRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddCategoryRouteArgs>();
      return _i1.AddCategoryPage(
        key: args.key,
        index: args.index,
        isEdit: args.isEdit,
      );
    },
  );
}

class AddCategoryRouteArgs {
  const AddCategoryRouteArgs({
    this.key,
    required this.index,
    required this.isEdit,
  });

  final _i11.Key? key;

  final int index;

  final bool isEdit;

  @override
  String toString() {
    return 'AddCategoryRouteArgs{key: $key, index: $index, isEdit: $isEdit}';
  }
}

/// generated route for
/// [_i2.AddTaskPage]
class AddTaskRoute extends _i10.PageRouteInfo<void> {
  const AddTaskRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AddTaskRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddTaskRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddTaskPage();
    },
  );
}

/// generated route for
/// [_i3.ArchievePage]
class ArchieveRoute extends _i10.PageRouteInfo<void> {
  const ArchieveRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ArchieveRoute.name,
          initialChildren: children,
        );

  static const String name = 'ArchieveRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.ArchievePage();
    },
  );
}

/// generated route for
/// [_i4.CategoryPage]
class CategoryRoute extends _i10.PageRouteInfo<void> {
  const CategoryRoute({List<_i10.PageRouteInfo>? children})
      : super(
          CategoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.CategoryPage();
    },
  );
}

/// generated route for
/// [_i5.EditTaskPage]
class EditTaskRoute extends _i10.PageRouteInfo<EditTaskRouteArgs> {
  EditTaskRoute({
    _i11.Key? key,
    required int taskIndex,
    required _i12.TaskModel model,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          EditTaskRoute.name,
          args: EditTaskRouteArgs(
            key: key,
            taskIndex: taskIndex,
            model: model,
          ),
          initialChildren: children,
        );

  static const String name = 'EditTaskRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditTaskRouteArgs>();
      return _i5.EditTaskPage(
        key: args.key,
        taskIndex: args.taskIndex,
        model: args.model,
      );
    },
  );
}

class EditTaskRouteArgs {
  const EditTaskRouteArgs({
    this.key,
    required this.taskIndex,
    required this.model,
  });

  final _i11.Key? key;

  final int taskIndex;

  final _i12.TaskModel model;

  @override
  String toString() {
    return 'EditTaskRouteArgs{key: $key, taskIndex: $taskIndex, model: $model}';
  }
}

/// generated route for
/// [_i6.InitialScreen]
class InitialRoute extends _i10.PageRouteInfo<void> {
  const InitialRoute({List<_i10.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.InitialScreen();
    },
  );
}

/// generated route for
/// [_i7.PickGradientScreen]
class PickGradientRoute extends _i10.PageRouteInfo<void> {
  const PickGradientRoute({List<_i10.PageRouteInfo>? children})
      : super(
          PickGradientRoute.name,
          initialChildren: children,
        );

  static const String name = 'PickGradientRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.PickGradientScreen();
    },
  );
}

/// generated route for
/// [_i8.SettingsPage]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.SettingsPage();
    },
  );
}

/// generated route for
/// [_i9.TaskListPage]
class TaskListRoute extends _i10.PageRouteInfo<void> {
  const TaskListRoute({List<_i10.PageRouteInfo>? children})
      : super(
          TaskListRoute.name,
          initialChildren: children,
        );

  static const String name = 'TaskListRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.TaskListPage();
    },
  );
}
