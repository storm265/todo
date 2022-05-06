import 'package:todo/repository/category_repository.dart';

class CategoryIndexController {
  int getCategoryIndex(String category) {
    var categoryBox = CategoryRepository().database;
    for (int i = 0; i < categoryBox.length; i++) {
      if (categoryBox.getAt(i)!.title == category) {
        return i;
      }
    }
    return 0;
  }
}
