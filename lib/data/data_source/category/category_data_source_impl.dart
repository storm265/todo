import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/data_source/category/category_data_source.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/category/category_model.dart';

class CategoryDataSourceImpl implements CategoryDataSource {
  final _categoryDatabase = Hive.box<CategoryModel>(DbScheme.categories);

  @override
  Box<CategoryModel> getDatabase() => _categoryDatabase;

  @override
  Future<void> save(CategoryModel model) async =>
      await _categoryDatabase.add(model);

  @override
  Future<void> delete(int index) async =>
      await _categoryDatabase.deleteAt(index);
}
