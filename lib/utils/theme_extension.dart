import 'package:flutter/cupertino.dart';

extension ThemeExtension on BuildContext {
  bool isDarkMode() => CupertinoTheme.of(this).brightness == Brightness.dark;
  bool isLightMode() => !isDarkMode();
  Color getThemeBrightnessColor() =>
      CupertinoTheme.of(this).scaffoldBackgroundColor;
  Color get cardColor =>
      isDarkMode() ? const Color(0xFF1D2030) : CupertinoColors.white;
  Color get secondaryTextColor =>
      isDarkMode() ? const Color(0xFFADB1C5) : const Color(0xFF73788E);
  Color get accentColor => CupertinoTheme.of(this).primaryColor;
}
