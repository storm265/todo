import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/controller/common/category_index_controller.dart';
import 'package:todo/controller/error_controller/error_service.dart';
import 'package:todo/data/model/category_bd/category_model.dart';
import 'package:todo/data/repository/category_repository.dart';
import 'package:todo/routes/routers.dart';
import 'package:todo/widgets/common/custom_snackbar_widget.dart';

// use consts for numbers
// rename
class CategoryController extends ChangeNotifier {
  final isDisabledButton = ValueNotifier<bool>(false);
  final imageFile = ValueNotifier(File(''));
  final picker = ImagePicker();
  final titleController = TextEditingController();

  final _categoryRepository = CategoryRepositoryImpl().database;
  final _categoryIndexController = CategoryIndexProvider();

  bool get _isImagePicked => imageFile.value.path.isNotEmpty;
  bool get _isTextValid => titleController.text.length >= 2;

  Future<void> validate(
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
      showMessage(context, 'Pick image and fill text!');
    } else if (!_isImagePicked) {
      showMessage(context, 'Pick image!');
    } else if (!_isTextValid) {
      showMessage(context, 'Text length must be >2');
    }
  }

  bool isSameCategoryFound(
    BuildContext context,
  ) {
    for (int i = 0; i < _categoryRepository.length; i++) {
      if (_categoryRepository.getAt(i)!.title.toLowerCase() ==
          titleController.text.toLowerCase()) {
        showMessage(context, 'This category  is already exists!');
        return true;
      }
    }
    return false;
  }

  Future<void> saveCategory(
    BuildContext context,
  ) async {
    try {
      if (!isSameCategoryFound(context)) {
        await _categoryRepository.add(CategoryModel(
            id: _categoryIndexController.getCategoryIndex(titleController.text),
            title: titleController.text,
            imgPath: imageFile.value.path));
        isDisabledButton.value = true;
        showMessage(context, 'Category is saved');
        await Routers.popDeyaled(context);
      }
    } catch (e) {
      ErrorService.printError('$e');
    }
  }

  Future<void> editCategory(
    int index,
    BuildContext context,
  ) async {
    try {
      if (!isSameCategoryFound(context)) {
        await _categoryRepository.putAt(
            index,
            CategoryModel(
                id: _categoryIndexController
                    .getCategoryIndex(titleController.text),
                title: titleController.text,
                imgPath: imageFile.value.path));
        isDisabledButton.value = true;
        showMessage(context, 'Category is updated');
        await Routers.popDeyaled(context);
      }
    } catch (e) {
      ErrorService.printError('$e');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      imageFile.value = File(file!.path);
      notifyListeners();
    } catch (e) {
      ErrorService.printError('$e');
    }
  }

  void showMessage(
    BuildContext context,
    String message,
  ) =>
      CustomSnackbarWidget.showCustomSnackbar(
          context: context, message: message);
}
