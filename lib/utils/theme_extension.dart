import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color getThemeBrightnessColor() =>
      Theme.of(this).brightness == Brightness.light
          ? Colors.white
          : Colors.black;

  bool isDarkMode() =>
        Theme.of(this).brightness == Brightness.dark ? true : false;

  bool isLightMode() =>
      Theme.of(this).brightness == Brightness.light ? true : false;
}
