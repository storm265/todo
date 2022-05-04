import 'package:flutter/material.dart';

class DismissStyleWidget extends StatelessWidget {
  const DismissStyleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text("Remove", style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}
