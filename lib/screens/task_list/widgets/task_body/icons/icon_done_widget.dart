import 'package:flutter/material.dart';
import 'package:todo/screens/widgets/gradient_color.dart';

class IconDoneWidget extends StatelessWidget {
  const IconDoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: Gradients.classicGradientLightMode,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.done,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
