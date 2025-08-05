import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../utils/styles/colors/colors_context.dart';
import '../widgets/bottom_bar_widget.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavigation({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.paddingOf(context).bottom - 14 <= 0
        ? 0.0
        : MediaQuery.paddingOf(context).bottom - 14;
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;
    return Column(
      children: [
        Expanded(
          child: navigationShell,
        ),
        ColoredBox(
          color: context.colors.background,
          child: BottomBarWidget(
            itemSelected: navigationShell.currentIndex,
            itemOnTap: _onTap,
          ).animate().moveY(begin: 100),
        ),
        Container(
          height: paddingBottom,
          color: isDarkMode
              ? context.colors.specificBasicSemiBlack
              : context.colors.specificBasicWhite,
        ),
      ],
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
