import 'package:hive_flutter/hive_flutter.dart';

abstract class UserConfigRepository {
  Future<Box> openConfigBox();

  Future<bool> getIsFirstTime();

  Future<void> putIsFirstTime(bool value);

  Future<void> closeBox();
}
