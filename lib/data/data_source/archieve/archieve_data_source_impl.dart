import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/data_source/archieve/archieve_data_source.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';

class ArchieveDataSourceImpl implements ArchieveDataSource {
  final _archieveDatabase = Hive.box<ArchieveModel>(DbScheme.archieve);

  @override
  Box<ArchieveModel> getDatabase() => _archieveDatabase;

  @override
  Future<void> save(ArchieveModel model) async =>
      await _archieveDatabase.add(model);

  @override
  Future<void> delete(int index) async =>
      await _archieveDatabase.deleteAt(index);
}
