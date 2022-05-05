import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/common/string_time_formatter.dart';
import 'package:todo/model/archieve_db/archieve_db.dart';
import 'package:todo/repository/archieve_repository.dart';
import 'package:todo/widgets/archieve/body.dart';
import 'package:todo/widgets/archieve/dismiss_style_widget.dart';
import 'package:todo/widgets/common/custom_app_bar_widget.dart';

class ArchievePage extends StatefulWidget {
  const ArchievePage({Key? key}) : super(key: key);

  @override
  _ArchievePageState createState() => _ArchievePageState();
}

class _ArchievePageState extends State<ArchievePage> {
  final Box<ArchieveModel> _categoryBox = ArchieveRepository().getDatabase();
  final _formatter = StringTimeFormatter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        buildContext: context,
        showActions: false,
        title: 'Archieve',
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _categoryBox.length,
          itemBuilder: (context, index) {
            final box = _categoryBox.getAt(index);

            String text = box!.text;
            String category = box.category;
            String deadlineDay =
                _formatter.formatTime(box.deadlineDateTime!.day);

            String deadlineMonth =
                _formatter.formatTime(box.deadlineDateTime!.month);
            String deadlineYear = '${box.deadlineDateTime!.year}';

            return Dismissible(
              onDismissed: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  await _categoryBox.deleteAt(index);
                }
              },
              key: UniqueKey(),
              background: const DismissStyleWidget(),
              child: ArchieveBodyWidget(
                category: category,
                deadlineDay: deadlineDay,
                deadlineMonth: deadlineMonth,
                deadlineYear: deadlineYear,
                text: text,
              ),
            );
          }),
    );
  }
}
