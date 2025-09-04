import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/task_list/controller/category_items.dart';
import 'package:todo/services/route_service/route_service.gr.dart';
import 'package:todo/utils/theme_extension.dart';

class ScheduleTopWidget extends StatelessWidget {
  const ScheduleTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(),
        IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () => _showDrawerDialog(context: context),
        ),
      ],
    );
  }
}

Future<void> _showDrawerDialog({required BuildContext context}) async {
  return showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => CupertinoAlertDialog(
      actions: [
        CupertinoButton(
          child: Text('Back'),
          onPressed: () {
            AutoRouter.of(context).popForced();
          },
        )
      ],
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.3,
        height: MediaQuery.sizeOf(context).height * 0.3,
        child: ListView.separated(
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () async {
                switch (i) {
                  case 0:
                    Navigator.pop(context);
                    await AutoRouter.of(context).push(
                      const CategoryRoute(),
                    );

                    break;
                  case 1:
                    Navigator.pop(context);
                    await AutoRouter.of(context).push(
                      const ArchieveRoute(),
                    );
                    break;
                  case 2:
                    Navigator.pop(context);
                    await AutoRouter.of(context).push(
                      const SettingsRoute(),
                    );
                    break;
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  spacing: 20,
                  children: [
                    Icon(drawerIcons[i]),
                    Text(
                      CategoryItems.values[i].type,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: context.isLightMode() ? Colors.black12 : Colors.white24,
          ),
          itemCount: CategoryItems.values.length,
        ),
      ),
    ),
  );
}
