import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/features/misc/components/scaffold_with_navigation.dart';
import 'package:go_router/go_router.dart';

class BottomTabBarShellRoute extends ShellRoute {
  final List<ScaffoldWithNavigationItem> tabs;

  BottomTabBarShellRoute({
    required this.tabs,
    super.navigatorKey,
    super.routes,
    Key? scaffoldKey = const ValueKey('ScaffoldWithNavBar'),
  }) : super(
          builder: (context, state, child) {
            return Stack(
              children: [
                // Needed to keep the (child) shell navigator alive
                Offstage(child: child),
                ScaffoldWithNavigation(
                  key: scaffoldKey,
                  tabItems: tabs
                      .map((tab) => tab.copyWith(text: tab.text.tr()))
                      .toList(),
                  currentNavigator:
                      (child as HeroControllerScope).child as Navigator,
                ),
              ],
            );
          },
        );
}
