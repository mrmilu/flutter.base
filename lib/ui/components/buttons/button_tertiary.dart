import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/icons/flutter_base_icon.dart';
import 'package:flutter_base/ui/components/icons/flutter_base_svg_icon.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/paddings.dart';
import 'package:flutter_base/ui/styles/text_styles.dart';
import 'package:flutter_base/ui/view_models/button_size.dart';

class ButtonTertiary extends TextButton {
  ButtonTertiary({
    super.key,
    required String text,
    Size? fixedSize,
    required super.onPressed,
    String iconName = '',
    IconData? iconData,
    Color? iconColor,
    ButtonSize size = ButtonSize.normal,
    TextStyle? customTextStyle,
  }) : super(
          style: TextButton.styleFrom(
            foregroundColor: FlutterBaseColors.specificSemanticPrimary,
            splashFactory: NoSplash.splashFactory,
            padding: Paddings.zero,
            visualDensity: VisualDensity.compact,
            fixedSize: fixedSize,
            minimumSize: fixedSize,
          ),
          child: _ButtonTertiaryContent(
            text: text,
            svgIconName: iconName,
            iconData: iconData,
            iconColor: iconColor,
            size: size,
            customTextStyle: customTextStyle,
          ),
        );
}

class _ButtonTertiaryContent extends StatelessWidget {
  final String text;
  final String svgIconName;
  final Color? iconColor;
  final IconData? iconData;
  final ButtonSize size;
  final TextStyle? customTextStyle;

  const _ButtonTertiaryContent({
    required this.text,
    required this.size,
    this.svgIconName = '',
    this.iconColor,
    this.customTextStyle,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          _hasIcon ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
      children: [
        if (_hasSvgIcon)
          FlutterBaseSvgIcon(
            iconName: svgIconName,
            width: _iconSize,
            height: _iconSize,
          ),
        if (_hasIconData)
          FlutterBaseIcon(
            icon: iconData,
            size: _iconSize,
          ),
        if (_hasIcon) BoxSpacer.h8(),
        Flexible(
          child: Text(
            text,
            style: _textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  TextStyle get _textStyle {
    return customTextStyle ??
        (ButtonSize.small == size
            ? TextStyles.midM
                .copyWith(color: FlutterBaseColors.specificSemanticPrimary)
            : TextStyles.smallL
                .copyWith(color: FlutterBaseColors.specificSemanticPrimary));
  }

  double get _iconSize => size == ButtonSize.small ? 16.0 : 24.0;

  bool get _hasIcon => _hasIconData || _hasSvgIcon;

  bool get _hasSvgIcon => svgIconName.isNotEmpty;

  bool get _hasIconData => iconData != null;
}
