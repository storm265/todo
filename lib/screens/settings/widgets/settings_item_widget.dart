import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/theme_extension.dart';

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    super.key,
    this.leadingIcon,
    this.title,
    this.trailing,
    this.onTap,
    this.leadingIconColor,
  });

  final FutureOr<void> Function()? onTap;

  final Color? leadingIconColor;

  final IconData? leadingIcon;

  final String? title;

  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoListTile(
          title: Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: Icon(
            leadingIcon,
            color: leadingIconColor,
          ),
          onTap: onTap,
          trailing: trailing,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Divider(
            color: context.isLightMode() ? Colors.black12 : Colors.white24,
          ),
        ),
      ],
    );
  }
}
