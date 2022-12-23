import 'package:flutter/material.dart';
import 'package:todo/screens/common_widgets/gradient_color.dart';

class IconDoneWidget extends StatelessWidget {
  const IconDoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      child: const Center(
        child: Icon(Icons.done, color: Colors.white, size: 18),
      ),
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              colors: Gradients.classicGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
    );
  }
}
