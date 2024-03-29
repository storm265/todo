import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/data_source/user_config/user_config_data_source.dart';
import 'package:todo/data/repository/user_config/user_config_repository.dart';

class UserConfigRepositoryImpl implements UserConfigRepository {
  final UserConfigDataSource _userConfigDataSource;

  UserConfigRepositoryImpl({required UserConfigDataSource userConfigDataSource})
      : _userConfigDataSource = userConfigDataSource;

  @override
  Future<void> closeBox() => _userConfigDataSource.closeBox();

  @override
  Future<Box> openConfigBox() => _userConfigDataSource.openConfigBox();

  @override
  Future<bool> getIsFirstTime() => _userConfigDataSource.getIsFirstTime();

  @override
  Future<void> putIsFirstTime(bool value) =>
      _userConfigDataSource.putIsFirstTime(value);
}
