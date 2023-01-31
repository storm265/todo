import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/data_source/category/category_data_source_impl.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/data/repository/category/category_repository_impl.dart';
import 'package:todo/screens/category/controller/category_list_controller.dart';
import 'package:todo/screens/category/widgets/category_card_widget.dart';
import 'package:todo/screens/widgets/custom_app_bar_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _categoryController = CategoryListController(
    categoryRepository: CategoryRepositoryImpl(
      categoryDataSource: CategoryDataSourceImpl(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        context: context,
        title: 'Categories',
        showActions: false,
      ),
      body: ValueListenableBuilder<Box<CategoryModel>>(
        valueListenable: _categoryController.getDataBase().listenable(),
        builder: (__, Box<CategoryModel> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (_, i) {
              CategoryModel categoryModel = box.getAt(i)!;
              return CategoryCardWidget(
                categoryController: _categoryController,
                categoryModel: categoryModel,
                index: i,
              );
            },
          );
        },
      ),
    );
  }
}
