import 'package:hive_flutter/hive_flutter.dart';

class ConfigurationRepository {
  Future<void> getBox() async {
     Hive.box('config');
  }

  Future<Box> openConfigBox() async {
    return await Hive.openBox('config');
  }

  Future<bool> getBoxValue() async {
    return Hive.box('config').get('isFirstTime') ?? true;
  }

  Future<void> putInBox(bool value) async {
    return Hive.box('config').put('isFirstTime', value);
  }
}
