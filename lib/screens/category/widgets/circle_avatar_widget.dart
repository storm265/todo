import 'dart:io';

import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String imgPath;
  const CircleAvatarWidget({Key? key, required this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: Colors.white,
        radius: 22,
        backgroundImage: ((imgPath.startsWith('assets')))
            ? (AssetImage(imgPath))
            : FileImage(File(imgPath)) as ImageProvider);
  }
}
