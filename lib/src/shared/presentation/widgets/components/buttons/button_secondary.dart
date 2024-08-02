import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/domain/types/button_size.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/text_styles.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/box_spacer.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/icons/flutter_base_icon.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/icons/flutter_base_svg_icon.dart';

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
    String iconName = '',
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
      return size == ButtonSize.small
          ? Insets.h12 + Insets.v8
          : Insets.h16 + Insets.v12;
    });
  }

  static MaterialStateProperty<Color?> _foregroundColor(ButtonSize size) {
    return MaterialStateProperty.resolveWith((states) {
      const smallColor = FlutterBaseColors.specificContentHigh;
      const normalColor = FlutterBaseColors.specificSemanticPrimary;

      if (states.contains(MaterialState.disabled)) {
        return size == ButtonSize.small
            ? smallColor.withOpacity(.5)
            : normalColor.withOpacity(.25);
      }

      if (states.contains(MaterialState.pressed)) {
        return size == ButtonSize.small
            ? smallColor.withOpacity(.6)
            : normalColor.withOpacity(.5);
      }
      return size == ButtonSize.small ? smallColor : normalColor;
    });
  }

  static MaterialStateProperty<Color?> _backgroundColor(ButtonSize size) {
    return MaterialStateProperty.resolveWith((states) {
      const smallColor = FlutterBaseColors.specificSemanticPrimary;
      const normalColor = FlutterBaseColors.specificBasicWhite;

      if (states.contains(MaterialState.disabled)) {
        return size == ButtonSize.small
            ? smallColor.withOpacity(.5)
            : normalColor.withOpacity(.25);
      }

      if (states.contains(MaterialState.pressed)) {
        return size == ButtonSize.small
            ? smallColor.withOpacity(.6)
            : normalColor.withOpacity(.5);
      }
      return size == ButtonSize.small ? smallColor : normalColor;
    });
  }
}

class _ButtonSecondaryContent extends StatelessWidget {
  final String text;
  final String svgIconName;
  final Color? iconColor;
  final IconData? iconData;
  final ButtonSize size;
  final TextStyle? customTextStyle;

  const _ButtonSecondaryContent({
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
        Center(
          child: Text(text, style: _textStyle),
        ),
      ],
    );
  }

  TextStyle get _textStyle {
    return customTextStyle ??
        (ButtonSize.small == size ? TextStyles.midM : TextStyles.smallL);
  }

  double get _iconSize => size == ButtonSize.small ? 16.0 : 24.0;

  bool get _hasIcon => _hasIconData || _hasSvgIcon;

  bool get _hasSvgIcon => svgIconName.isNotEmpty;

  bool get _hasIconData => iconData != null;
}
