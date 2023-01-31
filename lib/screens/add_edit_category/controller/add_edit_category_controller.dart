// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/data/data_source/category/category_data_source_impl.dart';
import 'package:todo/services/common/category_index_provider.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/repository/category/category_repository_impl.dart';
import 'package:todo/screens/widgets/custom_snackbar_widget.dart';

// TODO fix with SRP

class AddEditCategoryController extends ChangeNotifier {
  final isDisabledAddCategoryButton = ValueNotifier<bool>(false);
  final imageFile = ValueNotifier(File(''));
  final _imagePicker = ImagePicker();
  final titleController = TextEditingController();

  final categoryRepository =
      CategoryRepositoryImpl(categoryDataSource: CategoryDataSourceImpl())
          .getDatabase();
  final _categoryIndexController = CategoryIndexProvider();

  bool get _isImagePicked => imageFile.value.path.isNotEmpty;
  bool get _isTextValid => titleController.text.length >= 2;

  Future<void> changeButtonAddValue(bool isActive) async {
    if (!isActive) {
      await Future.delayed(const Duration(seconds: 1));
    }

    isDisabledAddCategoryButton.value = isActive;
  }

// TODO create validator class
  Future<void> tryValidate(
    bool isEdit,
    BuildContext context,
    int index,
  ) async {
    await changeButtonAddValue(true);
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
    await changeButtonAddValue(false);
  }

  // bool isSameCategoryFound(BuildContext context) {
  //   for (int i = 0; i < _categoryRepository.length; i++) {
  //     if (_categoryRepository.getAt(i)!.title.toLowerCase() ==
  //         titleController.text.toLowerCase()) {
  //       showSnackBar(context, 'This category  is already exists!');
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  Future<void> saveCategory(BuildContext context) async {
    await categoryRepository.add(
      CategoryModel(
        id: _categoryIndexController.getCategoryIndex(titleController.text),
        title: titleController.text,
        imgPath: imageFile.value.path,
      ),
    );

    showSnackBar(context, 'Category is saved');
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

    showSnackBar(context, 'Category is updated');
    Navigator.pop(context);
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
