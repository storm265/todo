import 'package:flutter/material.dart';
import 'package:todo/main.dart';

class IconDoneWidget extends StatelessWidget {
  const IconDoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MapEntry>(
      valueListenable: pickAvatarController.selectedGradient,
      builder: (context, selectedGradient, _) => Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: selectedGradient.value,
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
      ),
    );
  }
}
