import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/data_source/category/category_data_source.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/repository/category/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource _categoryDataSource;
  CategoryRepositoryImpl({required CategoryDataSource categoryDataSource})
      : _categoryDataSource = categoryDataSource;

  @override
  Box<CategoryModel> getDatabase() => _categoryDataSource.getDatabase();

  @override
  Future<void> save(CategoryModel model) async =>
      await _categoryDataSource.save(model);

  @override
  Future<void> delete(int index) async =>
      await _categoryDataSource.delete(index);
}
