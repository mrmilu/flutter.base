import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class BaseAdaptativeLayout extends StatelessWidget {
  final Widget body;
  final Widget? secondaryBody;
  final Widget bottomAppBar;
  final Widget navigationRail;
  const BaseAdaptativeLayout({
    super.key,
    required this.body,
    required this.bottomAppBar,
    required this.navigationRail,
    this.secondaryBody,
  });

  @override
  Widget build(BuildContext context) {
    final secondaryBodySlot = SlotLayout.from(
      key: const Key('secondary-body'),
      builder: (context) => secondaryBody ?? const SizedBox.shrink(),
    );
    final navigationRailSlot = SlotLayout.from(
      key: const Key('navigation-rail'),
      builder: (context) => navigationRail,
    );

    return AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('body'),
            builder: (context) => body,
          ),
          Breakpoints.medium: SlotLayout.from(
            key: const Key('body'),
            builder: (context) => body,
          ),
          Breakpoints.large: SlotLayout.from(
            key: const Key('body'),
            builder: (context) => Center(
              child: FractionallySizedBox(
                widthFactor: 0.66,
                child: body,
              ),
            ),
          ),
        },
      ),
      secondaryBody: secondaryBody != null
          ? SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.large: secondaryBodySlot,
              },
            )
          : null,
      primaryNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.large: navigationRailSlot,
          Breakpoints.medium: navigationRailSlot,
        },
      ),
      bottomNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('navigation-bottom'),
            builder: (context) => bottomAppBar,
          ),
        },
      ),
    );
  }
}
