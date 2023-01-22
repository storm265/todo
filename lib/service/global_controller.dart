import 'package:todo/service/common/category_index_provider.dart';
import 'package:todo/screens/task/controller/task_controller.dart';
import 'package:todo/data/repository/archieve_repository.dart';
import 'package:todo/data/repository/tasks_repository.dart';

// TODO remove it

final addEditController = AddEditTaskController(
  archieveRepository: ArchieveRepositoryImpl(),
  categoryIndexerProvider: CategoryIndexProvider(),
  tasksRepository: TasksRepositoryImpl(),
);
