import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/data_source/user_config/user_config_data_source.dart';
import 'package:todo/data/database/storage_sheme.dart';

class UserConfigDataSourceImpl implements UserConfigDataSource {
  @override
  Future<void> closeBox() async => await Hive.box(StorageScheme.config).close();

  @override
  Future<Box> openConfigBox() async => await Hive.openBox(StorageScheme.config);

  @override
  Future<bool> getIsFirstTime() async =>
      await Hive.box(StorageScheme.config).get(StorageScheme.isFirstTime) ??
      true;

  @override
  Future<void> putIsFirstTime(bool value) async =>
      await Hive.box(StorageScheme.config)
          .put(StorageScheme.isFirstTime, value);
}
