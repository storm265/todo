import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';


class ArchieveBodyWidget extends StatelessWidget {
  final ArchieveModel archieveModel;

  const ArchieveBodyWidget({
    Key? key,
    required this.archieveModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 5,
        shadowColor: Colors.grey,
        child: Container(
          width: 370,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: ListTile(
            title: Text(
              archieveModel.text,
              maxLines: 2,
            ),
            trailing: Text(archieveModel.category),
            subtitle: Text(
                'Finish at: ${DateFormat('dd/MM/yyyy').format(archieveModel.deadlineDateTime)}'),
          ),
        ),
      ),
    );
  }
}
