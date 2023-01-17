import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';

class ArchieveRepositoryImpl {
  final _archieveDatabase = Hive.box<ArchieveModel>(DbScheme.archieve);

  Box<ArchieveModel> get database => _archieveDatabase;

  Future<void> save(ArchieveModel model) async =>
      await _archieveDatabase.add(model);

  Future<void> delete(int index) async =>
      await _archieveDatabase.deleteAt(index);
}
