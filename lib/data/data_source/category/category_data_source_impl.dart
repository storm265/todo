import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/data_source/category/category_data_source.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/category/category_model.dart';

class CategoryDataSourceImpl implements CategoryDataSource {
  @override
  Box<CategoryModel> getDatabase() =>
      Hive.box<CategoryModel>(DbScheme.categories);

  @override
  Future<void> save(CategoryModel model) async =>
      await Hive.box<CategoryModel>(DbScheme.categories).add(model);

  @override
  Future<void> delete(int index) async =>
      await Hive.box<CategoryModel>(DbScheme.categories).deleteAt(index);
}
