import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';

class BaseAdaptativeLayout extends StatelessWidget {
  final Widget body;
  final Widget? secondaryBody;
  final Widget? bottomAppBar;
  final Widget? navigationRail;
  const BaseAdaptativeLayout({
    super.key,
    required this.body,
    this.bottomAppBar,
    this.navigationRail,
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
      builder: (context) => navigationRail ?? const SizedBox.shrink(),
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
            builder: (context) => Padding(
              padding: Insets.h16,
              child: body,
            ),
          ),
          Breakpoints.large: SlotLayout.from(
            key: const Key('body'),
            builder: (context) => ColoredBox(
              color: FlutterBaseColors.specificBackgroundBase,
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.66,
                  child: body,
                ),
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
      primaryNavigation: navigationRail != null
          ? SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.large: navigationRailSlot,
                Breakpoints.medium: navigationRailSlot,
              },
            )
          : null,
      bottomNavigation: bottomAppBar != null
          ? SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.small: SlotLayout.from(
                  key: const Key('navigation-bottom'),
                  builder: (context) => bottomAppBar ?? const SizedBox.shrink(),
                ),
              },
            )
          : null,
    );
  }
}
