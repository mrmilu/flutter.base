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

class ButtonPrimary extends ElevatedButton {
  ButtonPrimary({
    super.key,
    required super.onPressed,
    required String text,
    String iconName = '',
    IconData? iconData,
    ButtonSize size = ButtonSize.normal,
    visualDensity = VisualDensity.compact,
    Color? customForegroundColor,
    Color? customBackgroundColor,
  }) : super(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            visualDensity: visualDensity,
            minimumSize: WidgetStateProperty.all(_btnMinSizeMap[size]),
            fixedSize: WidgetStateProperty.all(_btnSizeMap[size]),
            enableFeedback: true,
            splashFactory: NoSplash.splashFactory,
            padding: _padding(size),
            foregroundColor: _foregroundColor(size, customForegroundColor),
            backgroundColor: _backgroundColor(size, customBackgroundColor),
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            elevation: WidgetStateProperty.all(0),
          ),
          child: _ButtonPrimaryContent(
            text: text,
            svgIconName: iconName,
            iconData: iconData,
            size: size,
          ),
        );

  static WidgetStateProperty<EdgeInsetsGeometry?> _padding(ButtonSize size) {
    return WidgetStateProperty.resolveWith((states) {
      return size == ButtonSize.small
          ? Insets.h12 + Insets.v8
          : Insets.h16 + Insets.v12;
    });
  }

  static WidgetStateProperty<Color?> _foregroundColor(
    ButtonSize size,
    Color? customForegroundColor,
  ) {
    return WidgetStateProperty.resolveWith((states) {
      final smallColor =
          customForegroundColor ?? FlutterBaseColors.specificSemanticPrimary;
      final normalColor =
          customForegroundColor ?? FlutterBaseColors.specificBasicWhite;

      if (states.contains(WidgetState.pressed)) {
        return size == ButtonSize.small
            ? smallColor.withOpacity(.6)
            : normalColor.withOpacity(.5);
      }
      return size == ButtonSize.small ? smallColor : normalColor;
    });
  }

  static WidgetStateProperty<Color?> _backgroundColor(
    ButtonSize size,
    Color? customBackgroundColor,
  ) {
    return WidgetStateProperty.resolveWith((states) {
      final smallColor =
          customBackgroundColor ?? FlutterBaseColors.specificSurfaceHigh;
      final normalColor =
          customBackgroundColor ?? FlutterBaseColors.specificSemanticPrimary;

      if (states.contains(WidgetState.disabled)) {
        return size == ButtonSize.small
            ? smallColor.withOpacity(.5)
            : normalColor.withOpacity(.25);
      }

      if (states.contains(WidgetState.pressed)) {
        return size == ButtonSize.small
            ? smallColor.withOpacity(.6)
            : normalColor.withOpacity(.5);
      }
      return size == ButtonSize.small ? smallColor : normalColor;
    });
  }
}

class _ButtonPrimaryContent extends StatelessWidget {
  final String text;
  final String svgIconName;
  final IconData? iconData;
  final ButtonSize size;

  const _ButtonPrimaryContent({
    required this.text,
    required this.size,
    this.svgIconName = '',
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
          child: Text(
            text,
            style:
                ButtonSize.small == size ? TextStyles.midM : TextStyles.smallL,
          ),
        ),
      ],
    );
  }

  double get _iconSize => size == ButtonSize.small ? 16.0 : 24.0;

  bool get _hasIcon => _hasIconData || _hasSvgIcon;

  bool get _hasSvgIcon => svgIconName.isNotEmpty;

  bool get _hasIconData => iconData != null;
}
