import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/components/navigation/app_navigation_bottom_bar.dart';
import 'package:flutter_base/ui/components/navigation/app_navigation_item.dart';
import 'package:flutter_base/ui/components/navigation/app_navigation_rail.dart';
import 'package:flutter_base/ui/components/views/base_adaptative_layout.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/insets.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigationItem extends AppNavigationItem {
  final String rootRoutePath;
  final GlobalKey<NavigatorState> navigatorKey;

  const ScaffoldWithNavigationItem({
    required this.rootRoutePath,
    required this.navigatorKey,
    super.text,
    super.customWidgetBuilder,
    super.icon,
    super.selectedIcon,
  });

  ScaffoldWithNavigationItem copyWith({
    IconData? icon,
    IconData? selectedIcon,
    String? text,
    Widget Function(bool selected)? customWidgetBuilder,
    String? rootRoutePath,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    return ScaffoldWithNavigationItem(
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      text: text ?? this.text,
      customWidgetBuilder: customWidgetBuilder ?? this.customWidgetBuilder,
      rootRoutePath: rootRoutePath ?? this.rootRoutePath,
      navigatorKey: navigatorKey ?? this.navigatorKey,
    );
  }
}

class ScaffoldWithNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<ScaffoldWithNavigationItem> tabItems;

  const ScaffoldWithNavigation({
    required this.navigationShell,
    required this.tabItems,
    super.key = const ValueKey<String>('ScaffoldWithNavBar'),
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ColoredBox(
        color: FlutterBaseColors.specificBackgroundBase,
        child: BaseAdaptativeLayout(
          body: navigationShell,
          navigationRail: AppNavigationRail(
            items: tabItems,
            selectedIndex: navigationShell.currentIndex,
            onItemTapped: _onTap,
          ),
          bottomAppBar: Padding(
            padding: Insets.a12,
            child: AppNavigationBottomBar(
              items: tabItems,
              selectedIndex: navigationShell.currentIndex,
              onItemTapped: _onTap,
            ),
          ),
        ),
      ),
    );
  }
}
