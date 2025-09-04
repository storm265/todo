import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todo/screens/settings/pick_gradient/gradient_utils.dart';
import 'package:todo/utils/user_prefs_provider.dart';

class SelectGradientItemCubit extends ChangeNotifier {
  SelectGradientItemCubit() {
    /// generating random gradient
    int random = Random().nextInt(GradientUtils.gradients.length) + 1;

    Future<void>.delayed(
      Duration.zero,
      () async {
        final themeId = await UserPrefsProvider.getCurrentGradient();
        if (themeId == null) {
          selectedGradient.value = MapEntry(
            GradientUtils.gradients.keys.elementAtOrNull(random) ??
                GradientUtils.gradients.keys.first,
            GradientUtils.gradients.values.elementAtOrNull(random) ??
                GradientUtils.gradients.values.first,
          );
        } else {
          final findItem = GradientUtils.gradients.entries
              .where(
                (element) => element.key == themeId,
              )
              .firstOrNull;

          if (findItem == null) {
            selectedGradient.value = MapEntry(
              GradientUtils.gradients.keys.elementAtOrNull(random) ??
                  GradientUtils.gradients.keys.first,
              GradientUtils.gradients.values.elementAtOrNull(random) ??
                  GradientUtils.gradients.values.first,
            );
            return;
          }

          selectedGradient.value = findItem;
        }
      },
    );

    pageConroller = PageController(
      keepPage: false,
      initialPage: random,
      viewportFraction: 0.55,
    );
  }

  late final PageController pageConroller;

  late final selectedGradient = ValueNotifier<MapEntry<String,List<Color>>>(
    MapEntry(
      GradientUtils.gradients.keys.first,
      GradientUtils.gradients.values.first,
    ),
  );

  int _pageIndex = 0;

  Future<void> switchBorderItem({required int index}) async {
    _pageIndex = index;
    await pageConroller.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.linear,
    );

    selectedGradient.value = GradientUtils.gradients.entries.elementAt(
      _pageIndex,
    );
  }
}
