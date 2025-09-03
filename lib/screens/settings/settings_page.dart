import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/annotations.dart';
import 'package:todo/main.dart';
import 'package:todo/screens/settings/widgets/settings_item_widget.dart';
import 'package:todo/services/route_service/route_service.gr.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Settings',
        ),
      ),
      child: SafeArea(
        left: false,
        right: false,
        child: Column(
          children: [
            SettingsItemWidget(
              leadingIcon: Icons.dark_mode,
              title: 'Dark Mode',
              trailing: ValueListenableBuilder<CupertinoThemeData>(
                valueListenable: themeController.currentTheme,
                builder: (context, theme, _) => CupertinoSwitch(
                  value: theme.brightness == Brightness.light ||
                          theme.brightness == Brightness.light
                      ? false
                      : true,
                  onChanged: (_) async =>
                      await themeController.switchTheme(context),
                ),
              ),
            ),
            SettingsItemWidget(
              leadingIcon: Icons.color_lens,
              title: 'Calendar Color',
              onTap: () async => await AutoRouter.of(context).push(
                PickGradientRoute(),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                'ToDo ${DateTime.now().year} \nMade with ❤ by NevoApps',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
