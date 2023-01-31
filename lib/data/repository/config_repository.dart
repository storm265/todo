import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database/db_sheme.dart';

abstract class FirstTimeVisitRepository {
  Future<Box> openConfigBox();
  Future<bool> getIsFirstTime();
  Future<void> putIsFirstTime(bool value);
  Future<void> closeBox();
}

class FirstTimeVisitRepositoryImpl implements FirstTimeVisitRepository {
  
  @override
  Future<void> closeBox() async => await Hive.close();

  @override
  Future<Box> openConfigBox() async => await Hive.openBox(DbScheme.config);

  @override
  Future<bool> getIsFirstTime() async =>
      await Hive.box(DbScheme.config).get(DbScheme.isFirstTime) ?? true;

  @override
  Future<void> putIsFirstTime(bool value) async =>
      await Hive.box(DbScheme.config).put(DbScheme.isFirstTime, value);
}
