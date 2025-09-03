import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

Future<void> showSnackBar(
  BuildContext context,
  String message,
) =>
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(message),
        actions: [
          CupertinoButton(
            child: Text('Back'),
            onPressed: () {
              AutoRouter.of(context).popForced();
            },
          )
        ],
      ),
    );
