import 'package:hive/hive.dart';
part 'archieve_db.g.dart'; // for build runner

// flutter packages pub run build_runner build --delete-conflicting-outputs
@HiveType(typeId: 2)
class ArchieveModel {
  @HiveField(0)
  String text;

  @HiveField(1)
  DateTime deadlineDateTime;

  @HiveField(2)
  String category;

  ArchieveModel({
    required this.deadlineDateTime,
    required this.text,
    required this.category,
  });
}
