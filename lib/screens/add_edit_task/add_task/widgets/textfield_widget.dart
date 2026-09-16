import 'package:flutter/cupertino.dart';
import 'package:todo/utils/theme_extension.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    super.key,
    required this.textEditingController,
    this.hintText,
    this.enabled = false,
    required this.validator,
  });
  final TextEditingController textEditingController;
  final String? hintText;
  final bool enabled;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: CupertinoTextFormFieldRow(
      enabled: enabled,
      controller: textEditingController,
      validator: validator,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      placeholder: hintText,
      placeholderStyle: TextStyle(color: context.secondaryTextColor),
      style: CupertinoTheme.of(context).textTheme.textStyle,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: context.secondaryTextColor.withValues(alpha: 0.1),
        ),
      ),
    ),
  );
}
