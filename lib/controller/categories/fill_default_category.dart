import 'package:todo/model/category_bd/category_model.dart';
import 'package:todo/repository/category_repository.dart';
import 'package:todo/repository/config_repository.dart';

class DefaultCategoryController {
  String get _assetsPath => 'assets/defaultCategoryIcons/';

  static const List<String> _categoryTitles = [
    'Event',
    'Personal',
    'Shopping',
    'Sport',
    'Work'
  ];

  Future<void> fillDefaultCategory() async {
    final _configRepository = FirstTimeVisitRepository();
    await _configRepository.openConfigBox();

    if (await _configRepository.getIsFirstTime()) {
      for (int i = 0; i < _categoryTitles.length; i++) {
        await CategoryRepository().database.add(CategoryModel(
            id: i,
            title: _categoryTitles[i],
            imgPath: '$_assetsPath${_categoryTitles[i]}.png'));
      }
    }
    await _configRepository.putIsFirstTime(false);
  }
}
