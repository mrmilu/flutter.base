import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/icons/flutter_base_icon.dart';
import 'package:flutter_base/ui/components/text/mid_text.dart';
import 'package:flutter_base/ui/styles/border_radius.dart';
import 'package:flutter_base/ui/styles/box_shadows.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/spacing.dart';
import 'package:flutter_base/ui/styles/text_styles.dart';

class AppBottomBarItem {
  final IconData? icon;
  final IconData? selectedIcon;
  final String? text;
  final Widget Function(bool selected)? customWidgetBuilder;

  const AppBottomBarItem({
    this.icon,
    this.selectedIcon,
    this.text,
    this.customWidgetBuilder,
  }) : assert(
          customWidgetBuilder != null || icon != null || selectedIcon != null,
          'Either an icon, selectedIcon or a customWidgetBuilder must be provided',
        );
}

class AppBottomBar extends StatelessWidget {
  final List<AppBottomBarItem> items;
  final int? selectedIndex;
  final Function(int idx)? onItemTapped;

  const AppBottomBar({
    super.key,
    required this.items,
    this.selectedIndex,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: CircularBorderRadius.br16,
        color: FlutterBaseColors.specificSurfaceLow,
        boxShadow: BoxShadows.bs1,
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Spacing.sp4, horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.asMap().entries.map(
            (entry) {
              final item = entry.value;
              final idx = entry.key;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _AppBottomBarItemWidget(
                  selected: idx == selectedIndex,
                  item: item,
                  onTap: () => onItemTapped?.call(idx),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class _AppBottomBarItemWidget extends StatelessWidget {
  final bool selected;
  final AppBottomBarItem item;
  final VoidCallback? onTap;

  const _AppBottomBarItemWidget({
    required this.selected,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Feedback.wrapForTap(onTap, context),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: _bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            item.customWidgetBuilder != null
                ? item.customWidgetBuilder!(selected)
                : FlutterBaseIcon(
                    icon:
                        selected ? item.selectedIcon ?? item.icon! : item.icon!,
                    color: _color,
                  ),
            if (item.text != null) ...[
              BoxSpacer.v8(),
              DefaultTextStyle(
                style: TextStyles.midXs,
                child: MidTextXs(
                  item.text!,
                  color: _color,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Color? get _bgColor =>
      selected ? FlutterBaseColors.specificSurfaceHigh : null;

  Color get _color => selected
      ? FlutterBaseColors.specificSemanticPrimary
      : FlutterBaseColors.specificContentLow;
}
