import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/screens/settings/pick_gradient/select_gradient_item_cubit.dart';
import 'package:todo/screens/settings/state/theme_controller.dart';
import 'package:todo/services/common/default_category_provider.dart';
import 'package:todo/data/database/local_storage_initializer.dart';
import 'package:todo/services/locator_service.dart';
import 'package:todo/services/route_service/route_service.dart';

final themeController = ThemeController();
 final pickAvatarController = SelectGradientItemCubit();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

      /// for android
      statusBarIconBrightness: Brightness.light,

      /// for ios
      statusBarBrightness: Brightness.light,
    ),
  );
  await LocalStorageInitializer.registerAdapters();
  await LocalStorageInitializer.openAllBoxes();

  initDependencies();

  await DefaultCategoryProvider.fillDefaultCategory();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = RouteService();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CupertinoThemeData>(
      valueListenable: themeController.currentTheme,
      builder: (context, theme, _) => CupertinoApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        title: 'ToDo',
        theme: theme,
      ),
    );
  }
}
