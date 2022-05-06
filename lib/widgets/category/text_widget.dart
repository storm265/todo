import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final int event;
  const TextWidget({Key? key, required this.event, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text('$event events',
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  color: Colors.black87))
        ],
      ),
    );
  }
}
