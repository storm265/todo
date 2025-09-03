// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/services/common/category_index_provider.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/services/locator_service.dart';
import 'package:todo/utils/show_dialog.dart';

// TODO fix with SRP

class AddEditCategoryController extends ChangeNotifier {
  final isDisabledAddCategoryButton = ValueNotifier<bool>(false);
  final imageFile = ValueNotifier(File(''));
  final _imagePicker = ImagePicker();
  final titleController = TextEditingController();

  final categoryRepository =
      serviceLocator<CategoryRepository<CategoryModel>>().getDatabase();
  final _categoryIndexController = CategoryIndexProvider();

  bool get _isImagePicked => imageFile.value.path.isNotEmpty;
  bool get _isTextValid => titleController.text.length >= 2;

// TODO create validator class
  Future<void> tryValidate(
    bool isEdit,
    BuildContext context,
    int index,
  ) async {
    isDisabledAddCategoryButton.value = true;
    if (_isTextValid && _isImagePicked) {
      isEdit ? await editCategory(index, context) : await saveCategory(context);
      isDisabledAddCategoryButton.value = false;
    }
    if (!_isImagePicked && !_isTextValid) {
      await showSnackBar(context, 'Pick image and fill text!');
      isDisabledAddCategoryButton.value = false;
      return;
    }
    if (!_isImagePicked) {
      await showSnackBar(context, 'Pick image!');
      isDisabledAddCategoryButton.value = false;
      return;
    }
    if (!_isTextValid) {
      await showSnackBar(context, 'Text length must be >2');
      isDisabledAddCategoryButton.value = false;
      return;
    }
  }

  Future<void> saveCategory(BuildContext context) async {
    await categoryRepository.add(
      CategoryModel(
        id: _categoryIndexController.getCategoryIndex(titleController.text),
        title: titleController.text,
        imgPath: imageFile.value.path,
      ),
    );

    Navigator.pop(context);
  }

  Future<void> editCategory(
    int index,
    BuildContext context,
  ) async {
    await categoryRepository.putAt(
        index,
        CategoryModel(
            id: _categoryIndexController.getCategoryIndex(titleController.text),
            title: titleController.text,
            imgPath: imageFile.value.path));

    Navigator.pop(context);
  }

  Future<void> pickImageFromGallery() async {
    XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      imageFile.value = File(file.path);
      imageFile.notifyListeners();
    }
  }
}
