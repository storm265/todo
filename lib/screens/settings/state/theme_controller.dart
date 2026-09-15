import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/utils/theme_extension.dart';
import 'package:todo/utils/theme_util.dart';
import 'package:todo/utils/user_prefs_provider.dart';

class ThemeController extends ChangeNotifier {
  ThemeController() {
    _initTheme();
  }

  final currentTheme =
      ValueNotifier<CupertinoThemeData>(CupertinoThemeUtil.lightTheme);

  Future<void> _initTheme() async {
    final isLigthMode = await UserPrefsProvider.getCurrentTheme();
    currentTheme.value = isLigthMode == null || isLigthMode == true
        ? CupertinoThemeUtil.lightTheme
        : CupertinoThemeUtil.darkTheme;
    currentTheme.notifyListeners();
  }

  Future<void> switchTheme(BuildContext context) async {
    final newTheme = currentTheme.value == CupertinoThemeUtil.lightTheme
        ? CupertinoThemeUtil.darkTheme
        : CupertinoThemeUtil.lightTheme;

    await UserPrefsProvider.saveTheme(
        isLigthMode:
            currentTheme.value == CupertinoThemeUtil.lightTheme ? false : true);
    currentTheme.value = newTheme;
    currentTheme.notifyListeners();

    _setSystemChromeThemed(context);
  }

  void _setSystemChromeThemed(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        /// for android
        statusBarIconBrightness:
            context.isLightMode() ? Brightness.light : Brightness.dark,

        /// for ios
        statusBarBrightness:
            context.isLightMode() ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
