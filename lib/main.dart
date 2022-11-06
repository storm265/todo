import 'package:flutter/material.dart';
import 'package:todo/controller/categories/default_category_provider.dart';
import 'package:todo/data/database/hive_init.dart';
import 'package:todo/controller/main_controller/system_chrome_controller.dart';
import 'package:todo/screens/task/tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChromeProvider.setSystemChrome();
  await DatabaseProvider.registerAdapters();
  await DatabaseProvider.openAllBoxes();
  await DefaultCategoryProvider.fillDefaultCategory();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo ToDo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Ubuntu',
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(
        maintainBottomViewPadding: true,
        bottom: false,
        child: TaskListPage(),
      ),
    );
  }
}
