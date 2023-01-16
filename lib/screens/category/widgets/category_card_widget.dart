import 'package:flutter/material.dart';
import 'package:todo/data/model/category_bd/category_model.dart';
import 'package:todo/screens/category/controller/category_list_controller.dart';
import 'package:todo/screens/category/widgets/circle_avatar_widget.dart';
import 'package:todo/screens/category/widgets/popup_buttons_widget.dart';

class CategoryCardWidget extends StatelessWidget {
  final int index;
  final CategoryModel categoryModel;
  final CategoryListController categoryController;
  const CategoryCardWidget({
    Key? key,
    required this.categoryModel,
    required this.categoryController,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 3,
        shadowColor: Colors.grey,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 350,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: SizedBox(
              width: 185,
              child: Text(
                categoryModel.title,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            subtitle: Text(
              '${categoryController.getCategoriesLength(index)} events',
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            leading: CircleAvatarWidget(imgPath: categoryModel.imgPath),
            trailing: PopupButtonsWidget(index: index),
          ),
        ),
      ),
    );
  }
}
