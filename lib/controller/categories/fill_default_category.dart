import 'package:flutter/material.dart';

import 'package:todo/model/category_bd/category_model.dart';
import 'package:todo/repository/category_repository.dart';
import 'package:todo/repository/config_repository.dart';

class DefaultCategoryController {
  static const List<String> _categoryTitles = [
    'Event',
    'Personal',
    'Shopping',
    'Sport',
    'Work'
  ];
  Future<void> fillDefaultCategory() async {
    final _configRepository = ConfigurationRepository();
    await _configRepository.openConfigBox();
    await _configRepository.getBox();
    final _categoryRepository = CategoryRepository().getDatabase();

    bool _isFirstTime = await _configRepository.getBoxValue();
    if (_isFirstTime) {
      debugPrint('filling category by default ');

      for (int i = 0; i < _categoryTitles.length; i++) {
        await _categoryRepository.add(CategoryModel(
            id: i,
            title: _categoryTitles[i],
            imgPath: 'assets/defaultCategoryIcons/${_categoryTitles[i]}.png'));
      }
    }
    await _configRepository.putInBox(false);
  }
}
