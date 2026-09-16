import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:todo/utils/theme_util.dart';
import 'package:todo/utils/user_prefs_provider.dart';

class ThemeController extends ChangeNotifier {
  final currentTheme = ValueNotifier<CupertinoThemeData>(
    CupertinoThemeUtil.lightTheme,
  );

  Future<void> load() async {
    final isLight = await UserPrefsProvider.getCurrentTheme() ?? true;
    currentTheme.value = isLight
        ? CupertinoThemeUtil.lightTheme
        : CupertinoThemeUtil.darkTheme;
    _setSystemChrome();
  }

  Future<void> switchTheme(BuildContext context) async {
    final isLight = currentTheme.value.brightness != Brightness.light;
    currentTheme.value = isLight
        ? CupertinoThemeUtil.lightTheme
        : CupertinoThemeUtil.darkTheme;
    _setSystemChrome();
    await UserPrefsProvider.saveTheme(isLigthMode: isLight);
  }

  void _setSystemChrome() {
    final isDark = currentTheme.value.brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: CupertinoColors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: currentTheme.value.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
    );
  }
}
