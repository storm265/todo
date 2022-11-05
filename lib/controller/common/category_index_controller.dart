import 'package:todo/data/repository/category_repository.dart';

//TODO should replace
class CategoryIndexProvider {
  int getCategoryIndex(String category) {
    var categoryBox = CategoryRepositoryImpl().database;
    for (int i = 0; i < categoryBox.length; i++) {
      if (categoryBox.getAt(i)!.title == category) {
        return i;
      }
    }
    return 0;
  }
}
