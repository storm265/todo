import 'package:flutter/material.dart';

class IconNotDoneWidget extends StatelessWidget {
  const IconNotDoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.grey),
        shape: BoxShape.circle,
      ),
    );
  }
}
