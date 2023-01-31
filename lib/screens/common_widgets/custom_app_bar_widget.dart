import 'package:flutter/material.dart';
import 'package:todo/screens/common_widgets/gradient_color.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  final String title;
  final bool showActions;
  final BuildContext context;
  final VoidCallback? addMethod;

  const CustomAppBarWidget({
    Key? key,
    required this.title,
    required this.showActions,
    required this.context,
    this.addMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
      ),
      actions: (showActions)
          ? [
              IconButton(
                icon: const Icon(Icons.control_point),
                onPressed: addMethod,
              )
            ]
          : [],
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      flexibleSpace: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: double.infinity,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
            )
          ],
          gradient: LinearGradient(
            colors: Gradients.classicGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}
