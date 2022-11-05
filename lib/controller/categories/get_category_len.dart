import 'package:todo/data/repository/category_repository.dart';
import 'package:todo/data/repository/tasks_repository.dart';
// TODO replace
class CategoryLength {
  int getCategoriesLength(int index) {
    final _categoryBox = CategoryRepositoryImpl().database;
    final _taskBox = TasksRepositoryImpl().database;
    List<int> _numbers = [];

    for (int i = 0; i < _categoryBox.length; i++) {
      _numbers.add(_taskBox.values
          .where((element) => element.category == _categoryBox.getAt(i)!.title)
          .toList()
          .length);
    }
    return _numbers[index];
  }
}
