import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/data/repository/archieve/archieve_repository.dart';
import 'package:todo/screens/archieve/archieve_controller.dart';
import 'package:todo/screens/archieve/widgets/archieve_body_widget.dart';
import 'package:todo/screens/archieve/widgets/dismiss_style_widget.dart';
import 'package:todo/screens/widgets/gradient_appbar_widget.dart';
import 'package:todo/services/locator_service.dart';
import 'package:todo/screens/widgets/empty_state_widget.dart';

@RoutePage()
class ArchievePage extends StatefulWidget {
  const ArchievePage({super.key});

  @override
  State<ArchievePage> createState() => _ArchievePageState();
}

class _ArchievePageState extends State<ArchievePage> {
  final _archieveController = ArchieveController(
    archieveRepository: serviceLocator<ArchieveRepository<ArchieveModel>>(),
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: GradientAppBarWidget(showActions: false, title: 'Archive'),
      child: _archieveController.getDatabase().isEmpty
          ? const Center(
              child: EmptyStateWidget(
                icon: CupertinoIcons.archivebox,
                title: 'Archive is empty',
                description: 'Archived tasks will appear here.',
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _archieveController.getDatabase().length,
              itemBuilder: (context, index) {
                final archieveModel = _archieveController.getDatabase().getAt(
                  index,
                );

                return Dismissible(
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      await _archieveController
                          .deleteItem(index: index)
                          .then((_) => setState(() {}));
                    }
                  },
                  key: UniqueKey(),
                  background: const DismissStyleWidget(),
                  child: ArchieveBodyWidget(archieveModel: archieveModel!),
                );
              },
            ),
    );
  }
}
