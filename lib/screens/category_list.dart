import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/categories/get_category_len.dart';
import 'package:todo/model/category_bd/category_model.dart';
import 'package:todo/repository/category_repository.dart';
import 'package:todo/widgets/category/body.dart';
import 'package:todo/widgets/category/circle_avatar_widget.dart';
import 'package:todo/widgets/category/popup_buttons_widget.dart';
import 'package:todo/widgets/category/text_widget.dart';
import 'package:todo/widgets/common/custom_app_bar_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _categoryBox = CategoryRepository().database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
          context: context, title: 'Caterogy', showActions: false),
      body: ValueListenableBuilder<Box<CategoryModel>>(
          valueListenable: _categoryBox.listenable(),
          builder: (context, Box<CategoryModel> box, _) {
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  CategoryModel _categoryModel = box.getAt(index)!;
                  return CategoryBodyWidget(widgets: [
                    CircleAvatarWidget(imgPath: _categoryModel.imgPath),
                    TextWidget(
                        event: CategoryLength().getCategoriesLength(index),
                        title: _categoryModel.title),
                    PopupButtonsWidget(index: index)
                  ]);
                });
          }),
    );
  }
}
