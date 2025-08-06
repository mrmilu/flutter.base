import 'package:flutter/material.dart';

import '../../utils/styles/colors/colors_context.dart';

class SimpleBlockWidget extends StatelessWidget {
  const SimpleBlockWidget({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.border,
    this.backgroundColor,
  });
  final Widget child;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        border: border,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  factory SimpleBlockWidget.withBorder({
    required BuildContext context,
    required Widget child,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Color? bordeColor,
    Color? backgroundColor,
  }) {
    return SimpleBlockWidget(
      padding: padding,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      border: Border.all(color: bordeColor ?? context.colors.disabled),
      child: child,
    );
  }
}
