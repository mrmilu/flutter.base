import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/icons/flutter_base_icon.dart';
import 'package:flutter_base/ui/components/navigation/app_navigation_item.dart';
import 'package:flutter_base/ui/components/text/mid_text.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/insets.dart';
import 'package:flutter_base/ui/styles/text_styles.dart';

class AppNavigationItemWidget extends StatelessWidget {
  final bool selected;
  final AppNavigationItem item;
  final VoidCallback? onTap;

  const AppNavigationItemWidget({
    required this.selected,
    required this.item,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.h4,
      child: GestureDetector(
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
                  ? item.customWidgetBuilder?.call(selected) ??
                      const SizedBox.shrink()
                  : FlutterBaseIcon(
                      icon: selected
                          // ignore: avoid-non-null-assertion
                          ? item.selectedIcon ?? item.icon!
                          // ignore: avoid-non-null-assertion
                          : item.icon!,
                      color: _color,
                    ),
              if (item.text.isNotEmpty) ...[
                BoxSpacer.v8(),
                DefaultTextStyle(
                  style: TextStyles.midXs,
                  child: MidTextXs(
                    item.text,
                    color: _color,
                  ),
                ),
              ],
            ],
          ),
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
