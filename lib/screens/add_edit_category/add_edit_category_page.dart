import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/screens/add_edit_category/controller/add_edit_category_controller.dart';
import 'package:todo/screens/widgets/gradient_appbar_widget.dart';
import 'package:todo/screens/widgets/unfocus_widget.dart';
import 'package:todo/services/locator_service.dart';

// TODO fix with SRP
@RoutePage()
class AddCategoryPage extends StatefulWidget {
  final bool isEdit;
  final int index;
  const AddCategoryPage({
    super.key,
    required this.index,
    required this.isEdit,
  });

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
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: GradientAppBarWidget(
        title: widget.isEdit ? 'Edit category' : 'Add category',
        showActions: false,
      ),
      child: UnfocusWidget(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              ValueListenableBuilder<File>(
                valueListenable: _categoryController.imageFile,
                builder: (context, imageFile, _) {
                  return (imageFile.path.isEmpty)
                      ? const Icon(Icons.image, color: Colors.blue, size: 80)
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              (imageFile.path.toString().startsWith('assets')
                                  ? (AssetImage(imageFile.path))
                                  : FileImage(
                                      File(imageFile.path),
                                    )) as ImageProvider);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CupertinoTextField(
                  controller: _categoryController.titleController,
                  placeholder: 'Title:',
                ),
              ),
              Column(
                spacing: 18.0,
                children: [
                  CupertinoButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        const Icon(Icons.file_download_outlined),
                        const Text('Upload photo')
                      ],
                    ),
                    onPressed: () async =>
                        await _categoryController.pickImageFromGallery(),
                  ),
                  ValueListenableBuilder<bool>(
                      valueListenable:
                          _categoryController.isDisabledAddCategoryButton,
                      builder: (context, isDisabled, _) {
                        return CupertinoButton.filled(
                          onPressed: isDisabled
                              ? null
                              : () => _categoryController.tryValidate(
                                    widget.isEdit,
                                    context,
                                    widget.index,
                                  ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 10,
                            children: [
                              const Icon(Icons.add),
                              Text(
                                '${(widget.isEdit) ? 'Edit' : 'Add'} category',
                              )
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
