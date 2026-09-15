import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoThemeUtil {
  static final darkTheme = const CupertinoThemeData(
    primaryColor: Colors.deepPurple,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        fontFamily: 'Ubuntu',
        color: CupertinoColors.white,
      ),
    ),
    brightness: Brightness.dark,
  );

  static final lightTheme = CupertinoThemeData(
    primaryColor: Colors.deepPurple,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        fontFamily: 'Ubuntu',
        color: CupertinoColors.black,
      ),
    ),
    brightness: Brightness.light,
  );
}
