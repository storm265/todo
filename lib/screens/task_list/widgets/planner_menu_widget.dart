import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/services/route_service/route_service.gr.dart';

class PlannerMenuWidget {
  static Future<void> show(BuildContext context) {
    final router = AutoRouter.of(context);
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (sheetContext) => CupertinoActionSheet(
        title: const Text('Your workspace'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(sheetContext);
              router.push(const CategoryRoute());
            },
            child: const Text('Categories'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(sheetContext);
              router.push(const ArchieveRoute());
            },
            child: const Text('Archive'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(sheetContext);
              router.push(const SettingsRoute());
            },
            child: const Text('Settings'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(sheetContext),
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}
