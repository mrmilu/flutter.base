import 'package:flutter/widgets.dart';

class AppNavigationItem {
  final IconData? icon;
  final IconData? selectedIcon;
  final String text;
  final Widget Function({bool selected})? customWidgetBuilder;

  const AppNavigationItem({
    this.icon,
    this.selectedIcon,
    this.text = '',
    this.customWidgetBuilder,
  }) : assert(
          customWidgetBuilder != null || icon != null || selectedIcon != null,
          'Either an icon, selectedIcon or a customWidgetBuilder must be provided',
        );
}
