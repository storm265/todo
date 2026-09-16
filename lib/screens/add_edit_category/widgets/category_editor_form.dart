import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:todo/screens/add_edit_category/controller/add_edit_category_controller.dart';
import 'package:todo/utils/theme_extension.dart';

class CategoryEditorForm extends StatelessWidget {
  const CategoryEditorForm({
    super.key,
    required this.controller,
    required this.isEdit,
    required this.index,
  });
  final AddEditCategoryController controller;
  final bool isEdit;
  final int index;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsetsGeometry.only(
      top: MediaQuery.paddingOf(context).top,
      bottom: MediaQuery.paddingOf(context).bottom,
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEdit ? 'Edit your category' : 'Keep things together',
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'A name and an image for related tasks.',
            style: TextStyle(color: context.secondaryTextColor, fontSize: 14),
          ),
          const SizedBox(height: 28),
          Center(
            child: ValueListenableBuilder<File>(
              valueListenable: controller.imageFile,
              builder: (context, file, _) {
                final ImageProvider? image = file.path.isEmpty
                    ? null
                    : file.path.startsWith('assets')
                    ? AssetImage(file.path)
                    : FileImage(file);
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: context.accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(32),
                    image: image == null
                        ? null
                        : DecorationImage(image: image, fit: BoxFit.cover),
                  ),
                  child: image == null
                      ? Icon(
                          CupertinoIcons.photo,
                          size: 42,
                          color: context.accentColor,
                        )
                      : null,
                );
              },
            ),
          ),
          Center(
            child: CupertinoButton(
              onPressed: controller.pickImageFromGallery,
              child: const Text('Choose image'),
            ),
          ),
          const SizedBox(height: 14),
          CupertinoTextField(
            controller: controller.titleController,
            placeholder: 'Category name',
            padding: const EdgeInsets.all(18),
            style: CupertinoTheme.of(context).textTheme.textStyle,
            placeholderStyle: TextStyle(color: context.secondaryTextColor),
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ValueListenableBuilder<bool>(
              valueListenable: controller.isDisabledAddCategoryButton,
              builder: (context, disabled, _) => CupertinoButton.filled(
                borderRadius: BorderRadius.circular(18),
                onPressed: disabled
                    ? null
                    : () => controller.tryValidate(isEdit, context, index),
                child: Text(isEdit ? 'Save changes' : 'Create category'),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
