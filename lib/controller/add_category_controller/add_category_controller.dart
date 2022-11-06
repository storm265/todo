import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/controller/common/category_index_provider.dart';
import 'package:todo/data/model/category_bd/category_model.dart';
import 'package:todo/data/repository/category_repository.dart';
import 'package:todo/widgets/common/custom_snackbar_widget.dart';

class AddCategoryController extends ChangeNotifier {
  final isDisabledButton = ValueNotifier<bool>(true);
  final imageFile = ValueNotifier(File(''));
  final _imagePicker = ImagePicker();
  final titleController = TextEditingController();

  final _categoryRepository = CategoryRepositoryImpl().database;
  final _categoryIndexController = CategoryIndexProvider();

  bool get _isImagePicked => imageFile.value.path.isNotEmpty;
  bool get _isTextValid => titleController.text.length >= 2;

  void changeButtonIsActive(bool newValue) {
    isDisabledButton.value = newValue;
    isDisabledButton.notifyListeners();
  }

  Future<void> tryValidate(
    bool isEdit,
    BuildContext context,
    int index,
  ) async {
    if (_isTextValid && _isImagePicked) {
      if (isEdit) {
        await editCategory(index, context);
      } else {
        await saveCategory(context);
      }
    } else if (!_isImagePicked && !_isTextValid) {
      showSnackBar(context, 'Pick image and fill text!');
    } else if (!_isImagePicked) {
      showSnackBar(context, 'Pick image!');
    } else if (!_isTextValid) {
      showSnackBar(context, 'Text length must be >2');
    }
  }

  bool isSameCategoryFound(BuildContext context) {
    for (int i = 0; i < _categoryRepository.length; i++) {
      if (_categoryRepository.getAt(i)!.title.toLowerCase() ==
          titleController.text.toLowerCase()) {
        showSnackBar(context, 'This category  is already exists!');
        return true;
      }
    }
    return false;
  }

  Future<void> saveCategory(BuildContext context) async {
    changeButtonIsActive(false);
    if (!isSameCategoryFound(context)) {
      await _categoryRepository.add(
        CategoryModel(
          id: _categoryIndexController.getCategoryIndex(titleController.text),
          title: titleController.text,
          imgPath: imageFile.value.path,
        ),
      );
      changeButtonIsActive(true);
      showSnackBar(context, 'Category is saved');
      Navigator.pop(context);
    }
  }

  Future<void> editCategory(
    int index,
    BuildContext context,
  ) async {
    changeButtonIsActive(false);
    if (!isSameCategoryFound(context)) {
      await _categoryRepository.putAt(
          index,
          CategoryModel(
              id: _categoryIndexController
                  .getCategoryIndex(titleController.text),
              title: titleController.text,
              imgPath: imageFile.value.path));
      changeButtonIsActive(true);
      showSnackBar(context, 'Category is updated');
        Navigator.pop(context);
    }
  }

  Future<void> pickImageFromGallery() async {
    XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      imageFile.value = File(file.path);
      imageFile.notifyListeners();
    }
  }

  void showSnackBar(
    BuildContext context,
    String message,
  ) =>
      CustomSnackbarWidget.showCustomSnackbar(
        context: context,
        message: message,
      );
}
