import 'package:flutter/cupertino.dart';

class CupertinoThemeUtil {
  static const lightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF6956DF),
    scaffoldBackgroundColor: Color(0xFFF5F6FA),
    barBackgroundColor: Color(0xF0F5F6FA),
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        fontFamily: 'Ubuntu',
        color: Color(0xFF202335),
        fontSize: 16,
      ),
    ),
  );

  static const darkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFFB4A6FF),
    scaffoldBackgroundColor: Color(0xFF11131D),
    barBackgroundColor: Color(0xF011131D),
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        fontFamily: 'Ubuntu',
        color: Color(0xFFF0F0F7),
        fontSize: 16,
      ),
    ),
  );
}
