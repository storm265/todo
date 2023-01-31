import 'package:todo/data/data_source/category/category_data_source_impl.dart';
import 'package:todo/data/data_source/tasks/tasks_data_source_impl.dart';
import 'package:todo/data/repository/category/category_repository_impl.dart';
import 'package:todo/data/repository/task/tasks_repository_impl.dart';

// TODO remove it

class CategoryListController {
  final _taskRepository = TasksRepositoryImpl(
    tasksDataSource: TasksDataSourceImpl(),
  ).getDatabase();
  final categoryBox =
      CategoryRepositoryImpl(categoryDataSource: CategoryDataSourceImpl())
          .getDatabase();

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
