import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/global_controller.dart';
import 'package:todo/data/model/category_bd/category_model.dart';
import 'package:todo/data/repository/category_repository.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  final _categoryRepository = CategoryRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _categoryRepository.database.listenable(),
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
                    onTap: () => setState(
                        () => addEditController.selectedCategory.value = index),
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
                                  color: (addEditController
                                              .selectedCategory.value ==
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
                    ));
              }),
        );
      },
    );
  }
}
