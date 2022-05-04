import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/model/archieve_db/archieve_db.dart';
import 'package:todo/model/category_bd/category_model.dart';
import 'package:todo/model/tasks_db/task_model.dart';

class DatabaseProvider {
  Future<void> registerAdapters() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDir.path);
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(ArchieveModelAdapter());
  }

  Future<void> openAllBoxes() async {
    await Hive.openBox<TaskModel>('tasks');
    await Hive.openBox<CategoryModel>('categories');
    await Hive.openBox<ArchieveModel>('archieve');
  }
}
