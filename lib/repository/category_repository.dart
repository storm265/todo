
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/error_controller/error_service.dart';
import 'package:todo/model/category_bd/category_model.dart';
import 'package:todo/repository/repository.dart';

class CategoryRepository implements Repository<CategoryModel> {
  final _categoryDatabase = Hive.box<CategoryModel>('categories');

  @override
  Box<CategoryModel> get database => _categoryDatabase;

  @override
  Future<void> save(CategoryModel model) async {
    try {
      await _categoryDatabase.add(model);
    } catch (e) {
      ErrorService.printError('$e');
    }
  }

  @override
  Future<void> delete(int index) async {
    try {
      await _categoryDatabase.deleteAt(index);
    } catch (e) {
        ErrorService.printError('$e');
    }
  }
}
