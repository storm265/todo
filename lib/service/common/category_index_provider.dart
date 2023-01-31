import 'package:todo/data/data_source/category/category_data_source_impl.dart';
import 'package:todo/data/repository/category/category_repository_impl.dart';

//TODO should replace
class CategoryIndexProvider {
  int getCategoryIndex(String category) {
    final categoryBox =
        CategoryRepositoryImpl(categoryDataSource: CategoryDataSourceImpl())
            .getDatabase();
    for (int i = 0; i < categoryBox.length; i++) {
      if (categoryBox.getAt(i)!.title == category) {
        return i;
      }
    }
    return 0;
  }
}
