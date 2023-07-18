import 'package:flutter/material.dart';
import 'package:todo/screens/task_list/widgets/task_body/body/gradient_boxes.dart';

class ConnectorDoneWidget extends StatelessWidget {
  const ConnectorDoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BodyColors.gradientTaskBody,
      child: const SizedBox(
        width: 3,
        height: 50,
      ),
    );
  }
}
