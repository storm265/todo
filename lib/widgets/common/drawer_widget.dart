import 'package:flutter/material.dart';
import 'package:todo/controller/task_list/drawer_items.dart';
import 'package:todo/routes/routers.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.pop(context);
                  Routers.toCategoryPage(context);

                  break;
                case 1:
                  Navigator.pop(context);
                  Routers.toAddArchievePage(context);
                  break;
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 40, top: 20, bottom: 20),
              child: Text(DrawerItems.values[index].type,
                  style: const TextStyle(fontSize: 25)),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(color: Colors.black),
        itemCount: DrawerItems.values.length,
      ),
    );
  }
}
