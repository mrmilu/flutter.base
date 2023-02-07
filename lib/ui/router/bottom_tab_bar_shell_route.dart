import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/features/misc/components/scaffold_with_nav_bar.dart';
import 'package:go_router/go_router.dart';

class BottomTabBarShellRoute extends ShellRoute {
  final List<ScaffoldWithNavBarTabItem> tabs;

  BottomTabBarShellRoute({
    required this.tabs,
    super.navigatorKey,
    super.routes,
    Key? scaffoldKey = const ValueKey('ScaffoldWithNavBar'),
  }) : super(
          builder: (context, state, Widget fauxNav) {
            return Stack(
              children: [
                // Needed to keep the (faux) shell navigator alive
                Offstage(child: fauxNav),
                ScaffoldWithNavBar(
                  key: scaffoldKey,
                  tabs: tabs
                      .map((tab) => tab.copyWith(text: tab.text?.tr()))
                      .toList(),
                  currentNavigator: fauxNav as Navigator,
                  currentRouterState: state,
                  routes: routes,
                ),
              ],
            );
          },
        );
}
