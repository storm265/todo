import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/model/category/category_model.dart';

abstract class CategoryRepository {
  Box<CategoryModel> getDatabase();

  Future<void> save(CategoryModel model);

  Future<void> delete(int index);
}
