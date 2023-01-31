import 'package:flutter/material.dart';
import 'package:todo/services/route_service.dart';
import 'package:todo/screens/category/controller/category_list_controller.dart';

class PopupButtonsWidget extends StatelessWidget {
  final CategoryListController categoryController;
  final int index;
  const PopupButtonsWidget({
    Key? key,
    required this.index,
    required this.categoryController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (int value) async {
          switch (value) {
            case 0:
              await RouteService.toAddEditCategoryPage(context, index, true);
              break;
            case 1:
              await categoryController.removeCategory(index: index);
              break;
          }
        },
        child: const Icon(
          Icons.more_horiz,
          color: Colors.black54,
          size: 35,
        ),
        itemBuilder: (_) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.edit),
                    Text("Edit"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.delete),
                    Text("Remove"),
                  ],
                ),
              ),
            ]);
  }
}
