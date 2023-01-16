import 'package:todo/data/repository/category_repository.dart';
import 'package:todo/data/repository/tasks_repository.dart';

class CategoryListController {
  final _taskRepository = TasksRepositoryImpl().database;
  final categoryBox = CategoryRepositoryImpl().database;

  int getCategoriesLength(int index) {
    final taskBox = _taskRepository;
    List<int> numbers = [];

    for (int i = 0; i < categoryBox.length; i++) {
      numbers.add(taskBox.values
          .where((element) => element.category == categoryBox.getAt(i)!.title)
          .toList()
          .length);
    }
    return numbers[index];
  }
}
