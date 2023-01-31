import 'package:todo/data/data_source/archieve/archieve_data_source_impl.dart';
import 'package:todo/data/repository/archieve/archieve_repository_impl.dart';
import 'package:todo/service/common/category_index_provider.dart';
import 'package:todo/screens/task/controller/task_controller.dart';
import 'package:todo/data/repository/tasks_repository.dart';

// TODO remove it

final addEditController = AddEditTaskController(
  archieveRepository: ArchieveRepositoryImpl(
    archieveDataSource: ArchieveDataSourceImpl(),
  ),
  categoryIndexerProvider: CategoryIndexProvider(),
  tasksRepository: TasksRepositoryImpl(),
);
