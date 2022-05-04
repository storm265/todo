import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/model/archieve_db/archieve_db.dart';
import 'package:todo/repository/repository.dart';

class ArchieveRepository implements Repository<ArchieveModel> {
  final _archieveDatabase = Hive.box<ArchieveModel>('archieve');

  @override
  Future<void> save(ArchieveModel model) async {
    await _archieveDatabase.add(model);
  }

  @override
  Box<ArchieveModel> getDatabase() {
    return _archieveDatabase;
  }

  @override
  void delete(int index) {
    _archieveDatabase.deleteAt(index);
  }


}
