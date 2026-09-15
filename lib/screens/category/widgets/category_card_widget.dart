import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/screens/category/controller/category_list_controller.dart';
import 'package:todo/screens/category/widgets/circle_avatar_widget.dart';
import 'package:todo/screens/category/widgets/popup_buttons_widget.dart';
import 'package:todo/utils/theme_extension.dart';

class CategoryCardWidget extends StatelessWidget {
  final int index;
  final CategoryModel categoryModel;

  final CategoryListController categoryController;

  const CategoryCardWidget({
    super.key,
    required this.categoryModel,
    required this.categoryController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 22,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: context.isLightMode() ? Colors.black12 : Colors.white70,
              blurRadius: 6,
              spreadRadius: 0.6,
            )
          ],
        ),
        child: Stack(
          children: [
            Row(
              spacing: 20,
              children: [
                CircleAvatarWidget(imgPath: categoryModel.imgPath),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Text(
                      categoryModel.title,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${categoryController.getCategoriesLength(index)} events',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: context.isLightMode()
                            ? Colors.black87
                            : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Icon(
                  Icons.more_horiz,
                  color: context.isDarkMode() ? Colors.white : Colors.black,
                  size: 28,
                ),
                onPressed: () async {
                  await showCategoriesActionSheet(
                      categoryTitle: categoryModel.title,
                      context: context,
                      index: index,
                      categoryController: categoryController);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
