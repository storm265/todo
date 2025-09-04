// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/screens/settings/pick_gradient/gradient_utils.dart';
import 'package:todo/screens/settings/pick_gradient/pick_avatar_widget.dart';
import 'package:todo/services/route_service/route_service.gr.dart';
import 'package:todo/utils/user_prefs_provider.dart';

@RoutePage()
class PickGradientScreen extends StatefulWidget {
  const PickGradientScreen({super.key});

  @override
  State<PickGradientScreen> createState() => _PickGradientScreenState();
}

class _PickGradientScreenState extends State<PickGradientScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
      child: Flex(
        direction: Axis.vertical,
        children: [
          PickAvatarWidget(
            selectGradientItemCubit: pickAvatarController,
          ),
          Expanded(
            child: Stack(
              children: [
                ValueListenableBuilder<MapEntry>(
                  valueListenable: pickAvatarController.selectedGradient,
                  builder: (context, selectedGradient, _) => GridView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: GradientUtils.gradients.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 110,
                      childAspectRatio: 1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        pickAvatarController.selectedGradient.value =
                            GradientUtils.gradients.entries.elementAt(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color:
                              pickAvatarController.selectedGradient.value.key ==
                                      GradientUtils.gradients.entries
                                          .elementAt(index)
                                          .key
                                  ? Colors.redAccent
                                  : Colors.transparent,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 4.0),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: GradientUtils.gradients.values
                                      .elementAt(index),
                                ),
                              ),
                            ),
                            Text(
                              GradientUtils.gradients.entries
                                  .elementAt(index)
                                  .key,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoButton.filled(
                      child: Text('Done'),
                      onPressed: () async {
                        await UserPrefsProvider.saveCurrentGradient(
                          gradientTitle:
                              pickAvatarController.selectedGradient.value.key,
                        );
                        await AutoRouter.of(context).replace(TaskListRoute());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
