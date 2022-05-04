import 'package:hive/hive.dart';
part 'category_model.g.dart'; // for build runner

// flutter packages pub run build_runner build --delete-conflicting-outputs
@HiveType(typeId: 0)
class CategoryModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String imgPath;

  CategoryModel({
    required this.id,
    required this.title,
    required this.imgPath,
  });
}
