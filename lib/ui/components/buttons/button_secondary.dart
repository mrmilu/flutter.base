import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/icons/flutter_base_icon.dart';
import 'package:flutter_base/ui/components/icons/flutter_base_svg_icon.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/spacing.dart';
import 'package:flutter_base/ui/styles/text_style.dart';
import 'package:flutter_base/ui/view_models/button_size.dart';

const _btnMinSizeMap = {
  ButtonSize.normal: Size(79, 48),
  ButtonSize.small: Size(62, 32),
};

const _btnSizeMap = {
  ButtonSize.normal: Size.fromHeight(48),
  ButtonSize.small: Size.fromHeight(32),
};

class ButtonSecondary extends OutlinedButton {
  ButtonSecondary({
    super.key,
    required super.onPressed,
    required String text,
    String? iconName,
    IconData? iconData,
    Color? iconColor,
    ButtonSize size = ButtonSize.normal,
    TextStyle? customTextStyle,
  }) : super(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(_btnMinSizeMap[size]),
            fixedSize: MaterialStateProperty.all(_btnSizeMap[size]),
            enableFeedback: true,
            splashFactory: NoSplash.splashFactory,
            padding: _padding(size),
            foregroundColor: _foregroundColor(size),
            backgroundColor: _backgroundColor(size),
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            elevation: MaterialStateProperty.all(0),
          ),
          child: _ButtonSecondaryContent(
            text: text,
            svgIconName: iconName,
            iconData: iconData,
            iconColor: iconColor,
            size: size,
            customTextStyle: customTextStyle,
          ),
        );

  static MaterialStateProperty<EdgeInsetsGeometry?> _padding(ButtonSize size) {
    return MaterialStateProperty.resolveWith((states) {
      if (size == ButtonSize.small) {
        return const EdgeInsets.symmetric(
          vertical: Spacing.sp8,
          horizontal: Spacing.sp12,
        );
      } else {
        return const EdgeInsets.symmetric(
          vertical: Spacing.sp12,
          horizontal: Spacing.sp16,
        );
      }
    });
  }

  static MaterialStateProperty<Color?> _foregroundColor(ButtonSize size) {
    return MaterialStateProperty.resolveWith((states) {
      const smallColor = MoggieColors.specificContentHigh;
      const normalColor = MoggieColors.specificSemanticPrimary;

      if (states.contains(MaterialState.disabled)) {
        if (size == ButtonSize.small) {
          return smallColor.withOpacity(.5);
        } else {
          return normalColor.withOpacity(.25);
        }
      }

      if (states.contains(MaterialState.pressed)) {
        if (size == ButtonSize.small) {
          return smallColor.withOpacity(.6);
        } else {
          return normalColor.withOpacity(.5);
        }
      }
      if (size == ButtonSize.small) {
        return smallColor;
      } else {
        return normalColor;
      }
    });
  }

  static MaterialStateProperty<Color?> _backgroundColor(ButtonSize size) {
    return MaterialStateProperty.resolveWith((states) {
      const smallColor = MoggieColors.specificSemanticPrimary;
      const normalColor = MoggieColors.specificBasicWhite;

      if (states.contains(MaterialState.disabled)) {
        if (size == ButtonSize.small) {
          return smallColor.withOpacity(.5);
        } else {
          return normalColor.withOpacity(.25);
        }
      }

      if (states.contains(MaterialState.pressed)) {
        if (size == ButtonSize.small) {
          return smallColor.withOpacity(.6);
        } else {
          return normalColor.withOpacity(.5);
        }
      }
      if (size == ButtonSize.small) {
        return smallColor;
      } else {
        return normalColor;
      }
    });
  }
}

class _ButtonSecondaryContent extends StatelessWidget {
  final String text;
  final String? svgIconName;
  final Color? iconColor;
  final IconData? iconData;
  final ButtonSize size;
  final TextStyle? customTextStyle;

  const _ButtonSecondaryContent({
    required this.text,
    required this.size,
    this.svgIconName,
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
            iconName: svgIconName!,
            width: _iconSize,
            height: _iconSize,
          ),
        if (_hasIconData)
          FlutterBaseIcon(
            icon: iconData!,
            size: _iconSize,
          ),
        if (_hasIcon) BoxSpacer.h8(),
        Center(
          child: Text(text, style: _textStyle),
        ),
      ],
    );
  }

  TextStyle get _textStyle {
    if (customTextStyle != null) return customTextStyle!;
    return ButtonSize.small == size
        ? MoggieTextStyles.midM
        : MoggieTextStyles.smallL;
  }

  double get _iconSize => size == ButtonSize.small ? 16.0 : 24.0;

  bool get _hasIcon => _hasIconData || _hasSvgIcon;

  bool get _hasSvgIcon => svgIconName != null;

  bool get _hasIconData => iconData != null;
}
