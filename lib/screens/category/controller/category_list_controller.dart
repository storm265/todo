import 'package:todo/data/repository/category_repository.dart';
import 'package:todo/data/repository/tasks_repository.dart';

class CategoryListController {
  final _taskRepository = TasksRepositoryImpl().database;
  final categoryBox = CategoryRepositoryImpl().database;

  int getCategoriesLength(int index) {
    final _taskBox = _taskRepository;
    List<int> _numbers = [];

    for (int i = 0; i < categoryBox.length; i++) {
      _numbers.add(_taskBox.values
          .where((element) => element.category == categoryBox.getAt(i)!.title)
          .toList()
          .length);
    }
    return _numbers[index];
  }
}
