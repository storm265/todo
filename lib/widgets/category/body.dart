import 'package:flutter/material.dart';

class CategoryBodyWidget extends StatelessWidget {
  final List<Widget> widgets;
  const CategoryBodyWidget({Key? key, required this.widgets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 5,
        shadowColor: Colors.grey,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 350,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: widgets,
          ),
        ),
      ),
    );
  }
}
