import 'package:flutter/material.dart';
import 'package:todo/controller/common/default_category_provider.dart';
import 'package:todo/data/database/hive_init.dart';
import 'package:todo/controller/system_chrome_controller.dart';
import 'package:todo/screens/task/task_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChromeProvider.setSystemChrome();
  await DatabaseProvider.registerAdapters();
  await DatabaseProvider.openAllBoxes();
  await DefaultCategoryProvider.fillDefaultCategory();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      theme: classicTheme,
      home: const SafeArea(
        child: TaskListPage(),
      ),
    );
  }
}

final classicTheme = ThemeData(
  useMaterial3: false,
  fontFamily: 'Ubuntu',
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
);

final darkTheme = ThemeData(
  useMaterial3: false,
  fontFamily: 'Ubuntu',
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.black,
);
