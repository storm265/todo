import 'package:flutter/material.dart';
import 'package:todo/data/data_source/archieve/archieve_data_source_impl.dart';
import 'package:todo/data/repository/archieve/archieve_repository_impl.dart';
import 'package:todo/screens/archieve/archieve_controller.dart';
import 'package:todo/screens/archieve/widgets/archieve_body_widget.dart';
import 'package:todo/screens/archieve/widgets/dismiss_style_widget.dart';
import 'package:todo/screens/common_widgets/custom_app_bar_widget.dart';

class ArchievePage extends StatefulWidget {
  const ArchievePage({Key? key}) : super(key: key);

  @override
  State<ArchievePage> createState() => _ArchievePageState();
}

class _ArchievePageState extends State<ArchievePage> {
  final _archieveController = ArchieveController(
    archieveRepository: ArchieveRepositoryImpl(
      archieveDataSource: ArchieveDataSourceImpl(),
    ),
  );

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
          itemCount: _archieveController.getDatabase().length,
          itemBuilder: (context, index) {
            final archieveModel =
                _archieveController.getDatabase().getAt(index);

            return Dismissible(
              onDismissed: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  await _archieveController
                      .deleteItem(index: index)
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
