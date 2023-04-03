// ignore_for_file: avoid-dynamic

import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/components/app_bottom_bar.dart';
import 'package:flutter_base/ui/extensions/media_query.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/paddings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBarTabItem extends AppBottomBarItem {
  final String rootRoutePath;
  final GlobalKey<NavigatorState> navigatorKey;

  const ScaffoldWithNavBarTabItem({
    required this.rootRoutePath,
    required this.navigatorKey,
    super.text,
    super.customWidgetBuilder,
    super.icon,
    super.selectedIcon,
  });

  ScaffoldWithNavBarTabItem copyWith({
    IconData? icon,
    IconData? selectedIcon,
    String? text,
    Widget Function(bool selected)? customWidgetBuilder,
    String? rootRoutePath,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    return ScaffoldWithNavBarTabItem(
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      text: text ?? this.text,
      customWidgetBuilder: customWidgetBuilder ?? this.customWidgetBuilder,
      rootRoutePath: rootRoutePath ?? this.rootRoutePath,
      navigatorKey: navigatorKey ?? this.navigatorKey,
    );
  }
}

class ScaffoldWithNavBar extends ConsumerStatefulWidget {
  final Navigator currentNavigator;
  final List<ScaffoldWithNavBarTabItem> tabs;
  final GoRouterState currentRouterState;
  final List<RouteBase> routes;

  List<Page<dynamic>> get pagesForCurrentRoute => currentNavigator.pages;

  const ScaffoldWithNavBar({
    required this.currentNavigator,
    required this.currentRouterState,
    required this.routes,
    required this.tabs,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ScaffoldWithNavBarState();
}

/// State for ScaffoldWithNavBar
class ScaffoldWithNavBarState extends ConsumerState<ScaffoldWithNavBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final List<_NavBarTabNavigator> _tabs;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabs = widget.tabs
        .map((ScaffoldWithNavBarTabItem e) => _NavBarTabNavigator(e))
        .toList();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  int _locationToTabIndex(String location) {
    final int index = _tabs.indexWhere(
      (_NavBarTabNavigator t) => location.startsWith(t.rootRoutePath),
    );
    return index < 0 ? 0 : index;
  }

  void _updateForCurrentTab() {
    final int previousIndex = _currentIndex;
    final location = GoRouter.of(context).location;
    _currentIndex = _locationToTabIndex(location);

    final _NavBarTabNavigator tabNav = _tabs[_currentIndex];
    tabNav.pages = widget.pagesForCurrentRoute;
    tabNav.lastLocation = location;

    if (previousIndex != _currentIndex) {
      _animationController.forward(from: 0.0);
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    final tab = _tabs[index];
    // (tab.navigatorKey as NavigatorState)
    if (_currentIndex == index) {
      GoRouter.of(context).go(tab.rootRoutePath);
    } else {
      GoRouter.of(context).go(tab.currentLocation);
    }
  }

  @override
  void didUpdateWidget(covariant ScaffoldWithNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateForCurrentTab();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateForCurrentTab();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ColoredBox(
        color: FlutterBaseColors.specificBackgroundBase,
        child: Stack(
          children: [
            Positioned.fill(
              child: FadeTransition(
                opacity: _animationController,
                child: IndexedStack(
                  index: _currentIndex,
                  children: _tabs
                      .map(
                        (_NavBarTabNavigator tab) =>
                            tab.buildNavigator(context),
                      )
                      .toList(),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).deviceBottomSafeArea,
              left: 0,
              right: 0,
              child: Padding(
                padding: Paddings.a12,
                child: AppBottomBar(
                  items: widget.tabs,
                  selectedIndex: _currentIndex,
                  onItemTapped: (int idx) => _onItemTapped(idx, context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Class representing a tab along with its navigation logic
class _NavBarTabNavigator {
  final ScaffoldWithNavBarTabItem bottomNavigationTab;
  List<Page<dynamic>> pages = <Page<dynamic>>[];
  String lastLocation = '';
  String get currentLocation =>
      lastLocation.isNotEmpty && lastLocation.contains(rootRoutePath)
          ? lastLocation
          : rootRoutePath;

  String get rootRoutePath => bottomNavigationTab.rootRoutePath;

  GlobalKey<NavigatorState>? get navigatorKey =>
      bottomNavigationTab.navigatorKey;

  _NavBarTabNavigator(this.bottomNavigationTab);

  Widget buildNavigator(BuildContext context) {
    return pages.isNotEmpty
        ? Navigator(
            key: navigatorKey,
            pages: pages,
            onPopPage: (Route<dynamic> route, result) {
              if (pages.length == 1 || !route.didPop(result)) {
                return false;
              }
              GoRouter.of(context).pop();
              return true;
            },
          )
        : const SizedBox.shrink();
  }
}
