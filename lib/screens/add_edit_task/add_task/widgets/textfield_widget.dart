import 'package:flutter/cupertino.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hintText;
  final bool enabled;
  final String? Function(String?) validator;

  const TextfieldWidget({
    super.key,
    required this.textEditingController,
    this.hintText,
    this.enabled = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CupertinoTextFormFieldRow(
        enabled: enabled,
        controller: textEditingController,
        validator: (value) => validator(value),
        keyboardType: TextInputType.text,
        placeholder: hintText,
        // TODO finish it
        // decoration: InputDecoration(
        //   hintText: hintText,
        //   border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        // ),
      ),
    );
  }
}
