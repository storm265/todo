import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/main.dart';
import 'package:todo/screens/settings/widgets/settings_item_widget.dart';
import 'package:todo/services/route_service/route_service.gr.dart';
import 'package:todo/utils/theme_extension.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    navigationBar: const CupertinoNavigationBar(middle: Text('Settings')),
    child: Padding(
      padding: EdgeInsetsGeometry.only(
        top: MediaQuery.paddingOf(context).top,
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Make it yours',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'A workspace that feels right, day and night.',
                  style: TextStyle(
                    color: context.secondaryTextColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SettingsItemWidget(
            leadingIcon: CupertinoIcons.moon_stars,
            title: 'Dark theme',
            trailing: ValueListenableBuilder<CupertinoThemeData>(
              valueListenable: themeController.currentTheme,
              builder: (context, theme, _) => CupertinoSwitch(
                value: theme.brightness == Brightness.dark,
                onChanged: (_) => themeController.switchTheme(context),
              ),
            ),
          ),
          SettingsItemWidget(
            leadingIcon: CupertinoIcons.paintbrush,
            title: 'Calendar color',
            onTap: () => AutoRouter.of(context).push(const PickGradientRoute()),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              'ToDo · ${DateTime.now().year}\nMade with ♥ by NevoApps',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.8,
                color: context.secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
