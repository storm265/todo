import 'package:todo/data/data_source/category/category_data_source_impl.dart';
import 'package:todo/data/data_source/user_config/user_config_data_source_impl.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/repository/category/category_repository_impl.dart';
import 'package:todo/data/repository/user_config/user_config_repository_impl.dart';

class DefaultCategoryProvider {
  static String get _assetsPath => 'assets/defaultCategoryIcons/';
  static const List<String> _categoryTitles = [
    'Event',
    'Personal',
    'Shopping',
    'Sport',
    'Work'
  ];

  static Future<void> fillDefaultCategory() async {
    final configRepository = UserConfigRepositoryImpl(
      userConfigDataSource: UserConfigDataSourceImpl(),
    );
    final categoryModel = CategoryRepositoryImpl(
      categoryDataSource: CategoryDataSourceImpl(),
    ).getDatabase();
    await configRepository.openConfigBox();

    if (await configRepository.getIsFirstTime()) {
      for (int i = 0; i < _categoryTitles.length; i++) {
        await categoryModel.add(
          CategoryModel(
            id: i,
            title: _categoryTitles[i],
            imgPath: '$_assetsPath${_categoryTitles[i]}.png',
          ),
        );
      }
    }
    await configRepository.putIsFirstTime(false);
    await configRepository.closeBox();
  }
}
