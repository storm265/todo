import 'package:flutter/material.dart';
import 'package:todo/main.dart';

class ConnectorDoneWidget extends StatelessWidget {
  const ConnectorDoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MapEntry>(
      valueListenable: pickAvatarController.selectedGradient,
      builder: (context, selectedGradient, _) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
            )
          ],
          gradient: LinearGradient(
            colors: selectedGradient.value,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: const SizedBox(
          width: 3,
          height: 50,
        ),
      ),
    );
  }
}
