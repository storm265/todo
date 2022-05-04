import 'package:flutter/material.dart';

class CustomSnackbarWidget {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showCustomSnackbar(
      BuildContext buildContext, String message,
      [int milliseconds = 1650]) {
    return ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      backgroundColor: Colors.black,
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
      ),
      duration: Duration(milliseconds: milliseconds),
    ));
  }
}
