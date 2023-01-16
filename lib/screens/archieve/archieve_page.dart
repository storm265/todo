import 'package:flutter/material.dart';
import 'package:todo/data/repository/archieve_repository.dart';
import 'package:todo/screens/archieve/widgets/archieve_body_widget.dart';
import 'package:todo/screens/archieve/widgets/dismiss_style_widget.dart';
import 'package:todo/screens/common_widgets/custom_app_bar_widget.dart';

// TODO create controller
class ArchievePage extends StatefulWidget {
  const ArchievePage({Key? key}) : super(key: key);

  @override
  State<ArchievePage> createState() => _ArchievePageState();
}

class _ArchievePageState extends State<ArchievePage> {
  final _categoryBox = ArchieveRepositoryImpl().database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        context: context,
        showActions: false,
        title: 'Archieve',
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _categoryBox.length,
          itemBuilder: (context, index) {
            final archieveModel = _categoryBox.getAt(index);

            return Dismissible(
              onDismissed: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  await _categoryBox
                      .deleteAt(index)
                      .then((_) => setState(() {}));
                }
              },
              key: UniqueKey(),
              background: const DismissStyleWidget(),
              child: ArchieveBodyWidget(
                archieveModel: archieveModel!,
              ),
            );
          }),
    );
  }
}
