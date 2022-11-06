import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/category_list_controller.dart';
import 'package:todo/data/model/category_bd/category_model.dart';
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
  final _categoryController = CategoryListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        context: context,
        title: 'Caterogy',
        showActions: false,
      ),
      body: ValueListenableBuilder<Box<CategoryModel>>(
          valueListenable: _categoryController.categoryBox.listenable(),
          builder: (__, Box<CategoryModel> box, _) {
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (_, i) {
                  CategoryModel _categoryModel = box.getAt(i)!;
                  return CategoryBodyWidget(
                    widgets: [
                      CircleAvatarWidget(imgPath: _categoryModel.imgPath),
                      TextWidget(
                        event: _categoryController.getCategoriesLength(i),
                        title: _categoryModel.title,
                      ),
                      PopupButtonsWidget(index: i)
                    ],
                  );
                });
          }),
    );
  }
}
