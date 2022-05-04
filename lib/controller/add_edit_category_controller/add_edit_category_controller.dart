import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/controller/common/category_index_controller.dart';
import 'package:todo/model/category_bd/category_model.dart';
import 'package:todo/repository/category_repository.dart';
import 'package:todo/routes/my_routes.dart';
import 'package:todo/widgets/common/custom_snackbar_widget.dart';

// use consts for numbers
// rename
class AddEditCategoryController extends ChangeNotifier {
  final isDisabled = ValueNotifier<bool>(false);
  final imageFile = ValueNotifier(File(''));
  final picker = ImagePicker();
  final titleController = TextEditingController();

  final _categoryRepository = CategoryRepository().getDatabase();
  final _categoryIndexController = CategoryIndexController();

  bool get isImageValid => imageFile.value.path.isNotEmpty;
  bool get isTextValid => titleController.text.length >= 2;

  Future<void> validate(bool isEdit, BuildContext context, int index) async {
    if (!isImageValid && !isTextValid) {
      showMessage(context, 'Pick image and fill text!');
    } else if (!isImageValid) {
      showMessage(context, 'Pick image!');
    } else if (!isTextValid) {
      showMessage(context, 'Text length must be >2');
    }
    // can save or edit
    if (isTextValid && isImageValid) {
      if (isEdit) {
        await editCategory(index, context);
      } else if (!isEdit) {
        await saveCategory(context);
      }
    }
  }

  bool findDublicates(BuildContext context) {
    for (int i = 0; i < _categoryRepository.length; i++) {
      if (_categoryRepository.getAt(i)!.title.compareTo(titleController.text) ==
          0) {
        showMessage(context, 'This category  is already exists!');
        return true;
      }
    }
    return false;
  }

  Future<void> saveCategory(BuildContext context) async {
    try {
      bool _isDublicate = findDublicates(context);
      if (!_isDublicate) {
        await _categoryRepository.add(CategoryModel(
          id: _categoryIndexController.getCategoryIndex(titleController.text),
          title: titleController.text,
          imgPath: imageFile.value.path,
        ));
        isDisabled.value = true;
        showMessage(context, 'Category is saved');
        await Routers().popDeyaled(context);
      }
    } catch (e) {
      debugPrint('saveCategory error!');
      showMessage(context, 'Error: $e');
    }
  }

  Future<void> editCategory(int index, BuildContext context) async {
    try {
      bool _isDublicate = findDublicates(context);
      if (!_isDublicate) {
        await _categoryRepository.putAt(
            index,
            CategoryModel(
                id: _categoryIndexController
                    .getCategoryIndex(titleController.text),
                title: titleController.text,
                imgPath: imageFile.value.path));
        isDisabled.value = true;
        showMessage(context, 'Category is updated');
        await Routers().popDeyaled(context);
      }
    } catch (e) {
      debugPrint('editCategory error!');
      showMessage(context, 'Error: $e');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      imageFile.value = File(file!.path);
      notifyListeners();
    } catch (e) {
      debugPrint('pickImageFromGallery error: $e');
    }
  }

  void showMessage(BuildContext context, String message) =>
      CustomSnackbarWidget().showCustomSnackbar(context, message);
}
