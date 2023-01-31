import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';

abstract class ArchieveDataSource {
  Box<ArchieveModel> getDatabase();

  Future<void> save(ArchieveModel model);

  Future<void> delete(int index);
}
