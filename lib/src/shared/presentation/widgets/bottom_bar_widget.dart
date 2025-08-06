import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../domain/types/app_navigation_type.dart';
import '../../domain/types/user_status_type.dart';
import '../utils/extensions/buildcontext_extensions.dart';
import '../utils/styles/colors/colors_context.dart';
import 'common/image_asset_widget.dart';

const double paddingDot = 50;

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    super.key,
    required this.itemOnTap,
    required this.itemSelected,
  });
  final Function(int) itemOnTap;
  final int itemSelected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final userIsClient =
            state.user?.status.name != UserStatusType.noClient.name;
        double paddingDot = userIsClient ? 50 : 120;
        int countNavigation = userIsClient ? 4 : 2;
        int indexSelected = (!userIsClient && (itemSelected == 3))
            ? 1
            : itemSelected;

        final brightness = Theme.of(context).brightness;
        final isDarkMode = brightness == Brightness.dark;

        return ColoredBox(
          color: isDarkMode
              ? context.colors.background
              : context.colors.specificBasicWhite,
          child: Column(
            children: [
              const Divider(
                height: 1,
                color: Colors.black12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  height: 100,
                  width: size.width,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                                AppNavigationType.getNavigationOptions(
                                  isClient: userIsClient,
                                ).map((e) {
                                  return ItemBottomBar(
                                    name: e.toTranslate(context),
                                    icon: e.iconPath,
                                    isSelected:
                                        itemSelected == e.getIndexRouting(),
                                    onTap: () {
                                      itemOnTap(e.getIndexRouting());
                                    },
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        bottom: 20,
                        left:
                            ((indexSelected * (size.width - 8)) /
                                countNavigation) +
                            (paddingDot / 2),
                        child: Center(
                          child: Container(
                            height: 3,
                            width: (size.width / countNavigation) - paddingDot,
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.white : Colors.black,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ItemBottomBar extends StatelessWidget {
  final String name;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;
  const ItemBottomBar({
    super.key,
    required this.name,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    int flex = isSelected ? 1 : 1;

    return Flexible(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: isSelected ? 28 : 28,
                  width: isSelected ? 28 : 28,
                  child: Center(
                    child: ImageAssetWidget(
                      path: icon,
                      height: isSelected ? 28 : 28,
                      width: isSelected ? 28 : 28,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 16,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: context.textTheme.labelMedium!.copyWith(
                        color: isSelected ? null : context.colors.grey,
                        fontWeight: isSelected ? FontWeight.bold : null,
                      ),
                      child: Text(name),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
