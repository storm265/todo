import 'package:flutter/material.dart';
import 'package:todo/controller/categories/fill_default_category.dart';
import 'package:todo/data/database/hive_init.dart';
import 'package:todo/controller/main_controller/system_chrome_controller.dart';
import 'package:todo/screens/tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChromeProvider().setSystemChrome();
  await DatabaseProvider().registerAdapters();
  await DatabaseProvider().openAllBoxes();
  await DefaultCategoryController().fillDefaultCategory();

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
      home: SafeArea(
        maintainBottomViewPadding: true,
        bottom: false,
        child: TaskListPage(),
      ),
    );
  }
}

class UnfocusWidget extends StatelessWidget {
  final Widget? child;
  const UnfocusWidget({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
