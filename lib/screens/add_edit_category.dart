import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo/controller/add_edit_category_controller/add_edit_category_controller.dart';
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
    super.initState();

    if (widget.isEdit) {
      var categoryBox = CategoryRepository().getDatabase().getAt(widget.index);
      _controller.imageFile.value = File(categoryBox!.imgPath);
      _controller.titleController.text = categoryBox.title;
    }
  }

  final _controller = AddEditCategoryController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        buildContext: context,
        title: 'Add category',
        showActions: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            ValueListenableBuilder<File>(
              valueListenable: _controller.imageFile,
              builder: (context, imageFile, _) {
                return (imageFile.path.isEmpty)
                    ? const Icon(
                        Icons.image,
                        color: Colors.blue,
                        size: 80,
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            (imageFile.path.toString().startsWith('assets')
                                ? (AssetImage(imageFile.path))
                                : FileImage(
                                    File(imageFile.path),
                                  )) as ImageProvider,
                      );
              },
            ),
            TextFieldWidget(textEditingController: _controller.titleController),
            ValueListenableBuilder<bool>(
                valueListenable: _controller.isDisabled,
                builder: (context, isDisabled, _) {
                  return Column(
                    children: [
                      OutlinedButton.icon(
                          onPressed: (isDisabled)
                              ? null
                              : () => _controller.pickImageFromGallery(),
                          icon: const Icon(Icons.file_download_outlined),
                          label: const Text('Upload photo')),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.add),
                        label: Text(
                            '${(widget.isEdit) ? 'Edit' : 'Add'} category'),
                        onPressed: (isDisabled)
                            ? null
                            : () => _controller.validate(
                                widget.isEdit, context, widget.index),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
