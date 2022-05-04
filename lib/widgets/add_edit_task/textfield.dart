import 'package:flutter/material.dart';

class AddEditTaskTextfieldWidget {
  Widget textField(TextEditingController textEditingController,
      [String hintText = '', bool enabled = false]) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        enabled: enabled,
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
