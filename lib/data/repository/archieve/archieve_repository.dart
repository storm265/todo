import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';

abstract class ArchieveRepository {
  Box<ArchieveModel> getDatabase();

  Future<void> save(ArchieveModel model);

  Future<void> delete(int index);
}
