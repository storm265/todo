import 'package:hive_flutter/hive_flutter.dart';

class FirstTimeVisitRepository {
  String get _boxName => 'config';
  String get _boxField => 'isFirstTime';

  Future<Box> openConfigBox() async {
    return await Hive.openBox(_boxName);
  }

  Future<bool> getIsFirstTime() async {
    return await Hive.box(_boxName).get(_boxField) ?? true;
  }

  Future<void> putIsFirstTime(bool value) async {
    return await Hive.box(_boxName).put(_boxField, value);
  }
}
