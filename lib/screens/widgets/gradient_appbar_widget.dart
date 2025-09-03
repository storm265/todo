import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientAppBarWidget extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  final String title;
  final bool showActions;

  final VoidCallback? onAddCallback;

  const GradientAppBarWidget({
    super.key,
    required this.title,
    required this.showActions,
    this.onAddCallback,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      trailing: showActions
          ? IconButton(
              icon: const Icon(Icons.control_point),
              onPressed: onAddCallback,
            )
          : SizedBox(),
      middle: Text(
        title,
      ),
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
