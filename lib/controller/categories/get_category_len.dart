import 'package:todo/repository/category_repository.dart';
import 'package:todo/repository/tasks_repository.dart';

class CategoryLength {
  int getCategoriesLength(int index) {
    final _categoryBox = CategoryRepository().database;
    final _taskBox = TasksRepository().database;
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
