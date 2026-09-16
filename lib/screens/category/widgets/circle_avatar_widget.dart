import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo/utils/theme_extension.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String imgPath;
  const CircleAvatarWidget({
    super.key,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: context.accentColor.withValues(alpha: 0.12),
        radius: 24,
        backgroundImage: ((imgPath.startsWith('assets')))
            ? (AssetImage(imgPath))
            : FileImage(File(imgPath)) as ImageProvider);
  }
}
