import 'package:flutter/material.dart';

class DialogPusherController {
  Future<void> rush(BuildContext context, VoidCallback callback) async {
    await Future.delayed(const Duration(milliseconds: 1))
        .then((_) => Navigator.pop(context))
        .then((_) => callback());
  }
}
