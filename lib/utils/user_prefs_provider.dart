import 'package:shared_preferences/shared_preferences.dart';

class UserPrefsProvider {
  static final _sharedPrefs = SharedPreferences.getInstance();

  // theme

  static Future<bool?> getCurrentTheme() async {
    final prefs = (await _sharedPrefs);
    return prefs.getBool('isLigthMode');
  }

  static Future<void> saveTheme({required bool isLigthMode}) async {
    final prefs = (await _sharedPrefs);
    await prefs.setBool('isLigthMode', isLigthMode);
  }
}
