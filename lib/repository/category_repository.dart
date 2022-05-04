import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/model/category_bd/category_model.dart';
import 'package:todo/repository/repository.dart';

class CategoryRepository implements Repository<CategoryModel> {
  final _categoryDatabase = Hive.box<CategoryModel>('categories');

  @override
  Future<void> save(CategoryModel model) async {
    try {
      await _categoryDatabase.add(model);
    } catch (e) {
      debugPrint('CategoryRepository save error!');
    }
  }

  @override
  Box<CategoryModel> getDatabase() {
    try {
      return _categoryDatabase;
    } catch (e) {
      debugPrint('CategoryRepository getDatabase error!');
    }
    return _categoryDatabase;
  }

  @override
  void delete(int index) {
    try {
      _categoryDatabase.deleteAt(index);
    } catch (e) {
      debugPrint('CategoryRepository delete error!');
    }
  }
}
