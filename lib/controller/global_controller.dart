
import 'package:todo/controller/common/category_index_provider.dart';
import 'package:todo/controller/common/string_time_formatter.dart';
import 'package:todo/screens/task/controller/task_controller.dart';
import 'package:todo/data/repository/archieve_repository.dart';
import 'package:todo/data/repository/tasks_repository.dart';

// TODO remove it

final addEditController = TaskController(
  archieveRepository: ArchieveRepositoryImpl(),
  categoryIndexerProvider: CategoryIndexProvider(),
  stringTimeFormatter: StringTimeFormatter(),
  tasksRepository: TasksRepositoryImpl(),
);
