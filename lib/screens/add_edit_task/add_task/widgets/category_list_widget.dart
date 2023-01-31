import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/model/category/category_model.dart';
import 'package:todo/screens/task/controller/task_controller.dart';

class CategoryListWidget extends StatefulWidget {
  final TaskController taskController;
  const CategoryListWidget({
    Key? key,
    required this.taskController,
  }) : super(key: key);

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
        return SizedBox(
          width: double.infinity,
          height: 90,
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
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
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
                            border: Border.all(
                                color: (widget.taskController
                                            .selectedCategoryIndex.value ==
                                        index)
                                    ? Colors.red
                                    : Colors.white,
                                width: 5),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                            categoryModel.title,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
