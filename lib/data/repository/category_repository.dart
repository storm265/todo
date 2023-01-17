import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/category/category_model.dart';

class CategoryRepositoryImpl {
  final _categoryDatabase = Hive.box<CategoryModel>(DbScheme.categories);

  Box<CategoryModel> get database => _categoryDatabase;

  Future<void> save(CategoryModel model) async =>
      await _categoryDatabase.add(model);

  Future<void> delete(int index) async =>
      await _categoryDatabase.deleteAt(index);
}
