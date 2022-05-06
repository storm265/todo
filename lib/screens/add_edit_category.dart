import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo/controller/category_controller/category_controller.dart';
import 'package:todo/repository/category_repository.dart';
import 'package:todo/widgets/add_edit_category/textfield_widget.dart';
import 'package:todo/widgets/common/custom_app_bar_widget.dart';

class AddCategoryPage extends StatefulWidget {
  final bool isEdit;
  final int index;
  const AddCategoryPage({Key? key, required this.index, required this.isEdit})
      : super(key: key);

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  @override
  void initState() {
    if (widget.isEdit) {
      var categoryBox = CategoryRepository().database.getAt(widget.index);
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

  final _categoryController = CategoryController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
          context: context, title: 'Add category', showActions: false),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
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
                                    : FileImage(File(imageFile.path)))
                                as ImageProvider);
              },
            ),
            TextFieldWidget(
                textEditingController: _categoryController.titleController),
            ValueListenableBuilder<bool>(
                valueListenable: _categoryController.isDisabledButton,
                builder: (context, isDisabled, _) {
                  return Column(
                    children: [
                      OutlinedButton.icon(
                          onPressed: (isDisabled)
                              ? null
                              : () =>
                                  _categoryController.pickImageFromGallery(),
                          icon: const Icon(Icons.file_download_outlined),
                          label: const Text('Upload photo')),
                      OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: Text(
                              '${(widget.isEdit) ? 'Edit' : 'Add'} category'),
                          onPressed: (isDisabled)
                              ? null
                              : () => _categoryController.validate(
                                  widget.isEdit, context, widget.index)),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
