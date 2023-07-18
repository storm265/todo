import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/data/database/storage_sheme.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/model/tasks/task_model.dart';

class LocalStorageInitializer {
  static Future<void> registerAdapters() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDir.path);
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(ArchieveModelAdapter());
  }

  static Future<void> openAllBoxes() async {
    await Hive.openBox<TaskModel>(StorageScheme.tasks);
    await Hive.openBox<CategoryModel>(StorageScheme.categories);
    await Hive.openBox<ArchieveModel>(StorageScheme.archieve);
  }
}
