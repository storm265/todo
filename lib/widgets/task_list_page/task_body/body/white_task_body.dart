import 'package:flutter/material.dart';
import 'package:todo/widgets/task_list_page/task_body/body/gradient_boxes.dart';

class WhiteNotDoneTaskBodyWidget extends StatelessWidget {
 final String text, category;
 const  WhiteNotDoneTaskBodyWidget(
      {Key? key, required this.text, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black87, fontSize: 18),
                ),
              ),
              Text(
                category,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              ),
            ],
          ),
        ),
        decoration: BodyColors.emptyTaskBody);
  }
}