import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/utils/theme_extension.dart';

class ArchieveBodyWidget extends StatelessWidget {
  final ArchieveModel archieveModel;

  const ArchieveBodyWidget({
    super.key,
    required this.archieveModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: context.isLightMode() ? Colors.black12 : Colors.white12,
              blurRadius: 6,
              spreadRadius: 0.6,
            )
          ],
        ),
        child: CupertinoListTile(
          title: Text(
            archieveModel.text,
            maxLines: 2,
          ),
          trailing: Text(archieveModel.category),
          subtitle: Text(
            'Finish at: ${DateFormat.yMd().format(archieveModel.deadlineDateTime)}',
          ),
        ),
      ),
    );
  }
}
