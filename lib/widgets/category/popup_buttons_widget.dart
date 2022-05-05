import 'package:flutter/material.dart';
import 'package:todo/repository/category_repository.dart';
import 'package:todo/routes/routers.dart';

class PopupButtonsWidget extends StatelessWidget {
  final int index;
  const PopupButtonsWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: PopupMenuButton(
          onSelected: (int value) {
            switch (value) {
              case 0:
                Routers().toAddEditCategoryPage(context, index, true);
                break;
              case 1:
                CategoryRepository().delete(index);
                break;
            }
          },
          child: const Icon(
            Icons.more_horiz,
            color: Colors.black54,
            size: 35,
          ),
          itemBuilder: (_) => [
                const PopupMenuItem(
                  child: Text("Edit"),
                  value: 0,
                ),
                const PopupMenuItem(
                  child: Text('Remove'),
                  value: 1,
                ),
              ]),
    );
  }
}
