import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/repository/category/category_repository.dart';
import 'package:todo/screens/category/controller/category_list_controller.dart';
import 'package:todo/screens/category/widgets/category_card_widget.dart';
import 'package:todo/screens/widgets/gradient_appbar_widget.dart';
import 'package:todo/services/locator_service.dart';
import 'package:todo/services/route_service/route_service.gr.dart';
import 'package:todo/screens/widgets/empty_state_widget.dart';

@RoutePage()
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _categoryController = CategoryListController(
    categoryRepository: serviceLocator<CategoryRepository<CategoryModel>>(),
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: GradientAppBarWidget(
        title: 'Categories',
        showActions: true,
        onAddCallback: () => AutoRouter.of(
          context,
        ).push(AddCategoryRoute(index: 0, isEdit: false)),
      ),
      child: ValueListenableBuilder<Box<CategoryModel>>(
        valueListenable: _categoryController.getDataBase().listenable(),
        builder: (context, Box<CategoryModel> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: EmptyStateWidget(
                icon: CupertinoIcons.folder,
                title: 'Everything in its place',
                description: 'Add a category to organize your tasks.',
              ),
            );
          }
          return CupertinoScrollbar(
            child: ListView.builder(
              itemCount: box.length,
              itemBuilder: (_, i) {
                CategoryModel categoryModel = box.getAt(i)!;
                return CategoryCardWidget(
                  categoryController: _categoryController,
                  categoryModel: categoryModel,
                  index: i,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
