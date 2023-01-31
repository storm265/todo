import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/data/repository/archieve/archieve_repository.dart';

class ArchieveController {
  final ArchieveRepository _archieveRepository;
  ArchieveController({required ArchieveRepository archieveRepository})
      : _archieveRepository = archieveRepository;

  Box<ArchieveModel> getDatabase() => _archieveRepository.getDatabase();

  Future<void> deleteItem({required int index}) async =>
      await _archieveRepository.delete(index);
}
