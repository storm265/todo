import 'package:flutter/material.dart';
import 'package:todo/data/repository/category_repository.dart';
import 'package:todo/routes/routers.dart';

class PopupButtonsWidget extends StatelessWidget {
  final int index;
  const PopupButtonsWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (int value) async {
          switch (value) {
            case 0:
              await Routers.toAddEditCategoryPage(context, index, true);
              break;
            case 1:
              await CategoryRepositoryImpl().delete(index);
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
