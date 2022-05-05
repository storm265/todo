import 'package:flutter/material.dart';

// bullshit
class DialogDelayedWrapper {
  Future<void> delayedPush(BuildContext context, Function callback) async {
    await Future.delayed(const Duration(milliseconds: 1))
        .then((_) => Navigator.pop(context))
        .then((_) => callback());
  }
}
