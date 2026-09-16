import 'package:flutter/cupertino.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/screens/category/controller/category_list_controller.dart';
import 'package:todo/screens/category/widgets/circle_avatar_widget.dart';
import 'package:todo/screens/category/widgets/popup_buttons_widget.dart';
import 'package:todo/utils/theme_extension.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    required this.categoryModel,
    required this.categoryController,
    required this.index,
  });
  final int index;
  final CategoryModel categoryModel;
  final CategoryListController categoryController;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: context.cardColor,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      children: [
        CircleAvatarWidget(imgPath: categoryModel.imgPath),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryModel.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${categoryController.getCategoriesLength(index)} tasks',
                style: TextStyle(
                  fontSize: 13,
                  color: context.secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
        CupertinoButton(
          padding: const EdgeInsets.all(8),
          onPressed: () => showCategoriesActionSheet(
            categoryTitle: categoryModel.title,
            context: context,
            index: index,
            categoryController: categoryController,
          ),
          child: Icon(
            CupertinoIcons.ellipsis,
            color: context.secondaryTextColor,
          ),
        ),
      ],
    ),
  );
}
