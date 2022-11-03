import 'package:flutter/material.dart';

class AddEditTaskTextfieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hintText;
  final bool? enabled;

  const AddEditTaskTextfieldWidget({
    Key? key,
    required this.textEditingController,
    this.hintText,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        enabled: enabled,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
