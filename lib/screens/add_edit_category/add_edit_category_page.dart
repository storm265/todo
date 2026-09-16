import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/screens/add_edit_category/controller/add_edit_category_controller.dart';
import 'package:todo/screens/widgets/gradient_appbar_widget.dart';
import 'package:todo/screens/add_edit_category/widgets/category_editor_form.dart';
import 'package:todo/services/locator_service.dart';

// TODO fix with SRP
@RoutePage()
class AddCategoryPage extends StatefulWidget {
  final bool isEdit;
  final int index;
  const AddCategoryPage({super.key, required this.index, required this.isEdit});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  @override
  void initState() {
    if (widget.isEdit) {
      final categoryBox = serviceLocator<CategoryRepository<CategoryModel>>()
          .getDatabase()
          .getAt(widget.index);
      _categoryController.imageFile.value = File(categoryBox!.imgPath);
      _categoryController.titleController.text = categoryBox.title;
    }
    super.initState();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _categoryController.titleController.dispose();
    super.dispose();
  }

  final _categoryController = AddEditCategoryController();
  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    navigationBar: GradientAppBarWidget(
      title: widget.isEdit ? 'Edit category' : 'Add category',
      showActions: false,
    ),
    child: CategoryEditorForm(
      controller: _categoryController,
      isEdit: widget.isEdit,
      index: widget.index,
    ),
  );
}
