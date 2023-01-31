import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/data_source/user_config/user_config_data_source.dart';
import 'package:todo/data/database/db_sheme.dart';

class UserConfigDataSourceImpl implements UserConfigDataSource {
  final _userConfigBox = Hive.box(DbScheme.config);

  @override
  Future<void> closeBox() async => await Hive.close();

  @override
  Future<Box> openConfigBox() async => await Hive.openBox(DbScheme.config);

  @override
  Future<bool> getIsFirstTime() async =>
      await _userConfigBox.get(DbScheme.isFirstTime) ?? true;

  @override
  Future<void> putIsFirstTime(bool value) async =>
      await _userConfigBox.put(DbScheme.isFirstTime, value);
}
