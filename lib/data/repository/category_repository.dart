import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/category_bd/category_model.dart';
import 'package:todo/data/repository/repository.dart';

class CategoryRepositoryImpl implements Repository<CategoryModel> {
  final _categoryDatabase = Hive.box<CategoryModel>(DbScheme.categories);

  @override
  Box<CategoryModel> get database => _categoryDatabase;

  @override
  Future<void> save(CategoryModel model) async =>
      await _categoryDatabase.add(model);

  @override
  Future<void> delete(int index) async =>
      await _categoryDatabase.deleteAt(index);
}
