import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/archieve_db/archieve_db.dart';
import 'package:todo/data/model/category_bd/category_model.dart';
import 'package:todo/data/model/tasks_db/task_model.dart';

class DatabaseProvider {
 static Future<void> registerAdapters() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDir.path);
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(ArchieveModelAdapter());
  }

 static Future<void> openAllBoxes() async {
    await Hive.openBox<TaskModel>(DbScheme.tasks);
    await Hive.openBox<CategoryModel>(DbScheme.categories);
    await Hive.openBox<ArchieveModel>(DbScheme.archieve);
  }
}
