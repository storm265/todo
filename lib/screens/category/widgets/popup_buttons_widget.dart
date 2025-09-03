import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/category/controller/category_list_controller.dart';
import 'package:todo/services/route_service/route_service.gr.dart';

Future<void> showCategoriesActionSheet({
  required BuildContext context,
  required int index,
  required CategoryListController categoryController,
  required String categoryTitle,
}) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text(
        categoryTitle,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 18,
        ),
      ),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () async {
            await AutoRouter.of(context).push(
              AddCategoryRoute(index: index, isEdit: true),
            );
          },
          child: Row(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Edit"),
              Icon(Icons.edit),
            ],
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            await categoryController.removeCategory(index: index);
          },
          child: Row(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Remove"),
              Icon(Icons.delete),
            ],
          ),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
