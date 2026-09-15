import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/screens/task_list/controller/task_controller.dart';

class CategoryListWidget extends StatefulWidget {
  final TaskController taskController;
  const CategoryListWidget({
    super.key,
    required this.taskController,
  });

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          widget.taskController.categoryRepository.getDatabase().listenable(),
      builder: (context, Box<CategoryModel> box, _) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 120, minHeight: 95),
          child: ListView.builder(
              itemCount: box.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                CategoryModel categoryModel = box.getAt(index)!;

                return GestureDetector(
                  onTap: () => setState(() => widget
                      .taskController.selectedCategoryIndex.value = index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: (widget.taskController.selectedCategoryIndex
                                    .value ==
                                index)
                            ? Colors.redAccent
                            : Colors.transparent,
                      ),
                      child: Column(
                        spacing: 6.0,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: (categoryModel.imgPath
                                          .startsWith('assets'))
                                      ? AssetImage(categoryModel.imgPath)
                                          as ImageProvider
                                      : FileImage(File(categoryModel.imgPath))),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            categoryModel.title,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .color),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
