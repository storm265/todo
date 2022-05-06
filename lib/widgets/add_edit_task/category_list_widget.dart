import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/global_controller.dart';
import 'package:todo/model/category_bd/category_model.dart';
import 'package:todo/repository/category_repository.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryRepository().database.listenable(),
      builder: (context, Box<CategoryModel> box, _) {
        return SizedBox(
          width: double.infinity,
          height: 90,
          child: ListView.builder(
              itemCount: box.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                CategoryModel _categoryModel = box.getAt(index)!;

                return GestureDetector(
                    onTap: () => setState(
                        () => addEditController.selectedCategory.value = index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: (_categoryModel.imgPath
                                            .startsWith('assets'))
                                        ? AssetImage(_categoryModel.imgPath)
                                            as ImageProvider
                                        : FileImage(
                                            File(_categoryModel.imgPath))),
                                border: Border.all(
                                    color: (addEditController
                                                .selectedCategory.value ==
                                            index)
                                        ? Colors.red
                                        : Colors.white,
                                    width: 5),
                                shape: BoxShape.circle),
                          ),
                          Text(_categoryModel.title)
                        ],
                      ),
                    ));
              }),
        );
      },
    );
  }
}
