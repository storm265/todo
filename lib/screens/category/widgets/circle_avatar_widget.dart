import 'dart:io';
import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String imgPath;
  const CircleAvatarWidget({
    super.key,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: Colors.white,
        radius: 24,
        backgroundImage: ((imgPath.startsWith('assets')))
            ? (AssetImage(imgPath))
            : FileImage(File(imgPath)) as ImageProvider);
  }
}
