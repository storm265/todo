import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo/services/route_service/route_service.gr.dart';
import 'package:todo/utils/user_prefs_provider.dart';

@RoutePage()
class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(),
      () async {
        final isFirstRun = await UserPrefsProvider.getCurrentGradient();
        isFirstRun == null
            ? await AutoRouter.of(context).replace(PickGradientRoute())
            : await AutoRouter.of(context).replace(TaskListRoute());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
