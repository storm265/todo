import 'package:hive_flutter/hive_flutter.dart';

abstract class Repository<T> {
  Box<T> get database;

  Future<void> save(T model);

  Future<void> delete(int index);
}
