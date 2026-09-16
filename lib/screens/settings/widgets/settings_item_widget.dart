import 'dart:async';
import 'package:flutter/cupertino.dart';
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
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(18, 6, 18, 6),
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      color: context.cardColor,
      borderRadius: BorderRadius.circular(22),
    ),
    child: CupertinoListTile(
      title: Text(
        title ?? '',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      leading: Icon(
        leadingIcon,
        color: leadingIconColor ?? context.accentColor,
        size: 22,
      ),
      onTap: onTap,
      trailing:
          trailing ??
          Icon(
            CupertinoIcons.chevron_right,
            color: context.secondaryTextColor,
            size: 18,
          ),
    ),
  );
}
