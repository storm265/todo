import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database/db_sheme.dart';
import 'package:todo/data/model/archieve_db/archieve_db.dart';
import 'package:todo/data/repository/repository.dart';

class ArchieveRepositoryImpl implements Repository<ArchieveModel> {
  final _archieveDatabase = Hive.box<ArchieveModel>(DbScheme.archieve);

  @override
  Box<ArchieveModel> get database => _archieveDatabase;

  @override
  Future<void> save(ArchieveModel model) async =>
      await _archieveDatabase.add(model);

  @override
  Future<void> delete(int index) async =>
      await _archieveDatabase.deleteAt(index);
}
