import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/components/navigation/app_navigation_bottom_bar.dart';
import 'package:flutter_base/ui/components/navigation/app_navigation_item.dart';
import 'package:flutter_base/ui/components/navigation/app_navigation_rail.dart';
import 'package:flutter_base/ui/components/views/base_adaptative_layout.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/paddings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class ScaffoldWithNavigation extends ConsumerStatefulWidget {
  final Navigator currentNavigator;
  final List<ScaffoldWithNavigationItem> tabItems;

  List<Page> get pagesForCurrentRoute => currentNavigator.pages;

  const ScaffoldWithNavigation({
    required this.currentNavigator,
    required this.tabItems,
    super.key = const ValueKey<String>('ScaffoldWithNavBar'),
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ScaffoldWithNavBarState();
}

/// State for ScaffoldWithNavBar
class ScaffoldWithNavBarState extends ConsumerState<ScaffoldWithNavigation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final List<_TabPagesNavigator> _tabPages;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabPages = widget.tabItems
        .map((ScaffoldWithNavigationItem e) => _TabPagesNavigator(e))
        .toList();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  int _locationToTabIndex(String location) {
    final int index = _tabPages.indexWhere(
      (_TabPagesNavigator t) => location.startsWith(t.rootRoutePath),
    );
    return index < 0 ? 0 : index;
  }

  void _updateForCurrentTab() {
    final int previousIndex = _currentIndex;
    final location = GoRouter.of(context).location;
    _currentIndex = _locationToTabIndex(location);

    final _TabPagesNavigator tabNav = _tabPages[_currentIndex];
    tabNav.pages = widget.pagesForCurrentRoute;
    tabNav.lastLocation = location;

    if (previousIndex != _currentIndex) {
      _animationController.forward(from: 0.0);
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    final tab = _tabPages[index];

    GoRouter.of(context)
        .go(_currentIndex == index ? tab.rootRoutePath : tab.currentLocation);
  }

  @override
  void didUpdateWidget(covariant ScaffoldWithNavigation oldWidget) {
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
    final tabNavigators = _tabPages
        .map(
          (_TabPagesNavigator tab) => tab.buildNavigator(context),
        )
        .toList();

    return SizedBox.expand(
      child: ColoredBox(
        color: FlutterBaseColors.specificBackgroundBase,
        child: BaseAdaptativeLayout(
          body: FadeTransition(
            opacity: _animationController,
            child: IndexedStack(
              index: _currentIndex,
              children: tabNavigators,
            ),
          ),
          navigationRail: AppNavigationRail(
            items: widget.tabItems,
            selectedIndex: _currentIndex,
            onItemTapped: (int idx) => _onItemTapped(idx, context),
          ),
          bottomAppBar: Padding(
            padding: Paddings.a12,
            child: AppNavigationBottomBar(
              items: widget.tabItems,
              selectedIndex: _currentIndex,
              onItemTapped: (int idx) => _onItemTapped(idx, context),
            ),
          ),
        ),
      ),
    );
  }
}

/// Class representing a tab along with its navigation logic
class _TabPagesNavigator {
  final ScaffoldWithNavigationItem bottomNavigationTab;
  List<Page> pages = <Page>[];
  String lastLocation = '';
  String get currentLocation =>
      lastLocation.isNotEmpty && lastLocation.contains(rootRoutePath)
          ? lastLocation
          : rootRoutePath;

  String get rootRoutePath => bottomNavigationTab.rootRoutePath;

  GlobalKey<NavigatorState>? get navigatorKey =>
      bottomNavigationTab.navigatorKey;

  _TabPagesNavigator(this.bottomNavigationTab);

  Widget buildNavigator(BuildContext context) {
    return pages.isNotEmpty
        ? ClipRect(
            child: Navigator(
              key: navigatorKey,
              pages: pages,
              clipBehavior: Clip.antiAlias,
              onPopPage: (Route route, result) {
                if (pages.length == 1 || !route.didPop(result)) {
                  return false;
                }
                GoRouter.of(context).pop();
                return true;
              },
            ),
          )
        : const SizedBox.shrink();
  }
}
