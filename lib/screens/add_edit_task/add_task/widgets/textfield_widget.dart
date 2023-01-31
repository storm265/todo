import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hintText;
  final bool enabled;
  final String? Function(String?) validator;

  const TextfieldWidget({
    Key? key,
    required this.textEditingController,
    this.hintText,
    this.enabled = false,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        enabled: enabled,
        controller: textEditingController,
        validator: (value) => validator(value),
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
