import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/domain/types/button_size.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/icons/flutter_base_icon.dart';

const _btnSizeMap = {
  ButtonSize.normal: Size(48, 48),
  ButtonSize.small: Size(32, 32),
};

class IconButtonSecondary extends OutlinedButton {
  IconButtonSecondary({
    super.key,
    required super.onPressed,
    required IconData icon,
    ButtonSize size = ButtonSize.normal,
  }) : super(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            minimumSize: WidgetStateProperty.all(_btnSizeMap[size]),
            fixedSize: WidgetStateProperty.all(_btnSizeMap[size]),
            maximumSize: WidgetStateProperty.all(_btnSizeMap[size]),
            enableFeedback: true,
            splashFactory: NoSplash.splashFactory,
            padding: WidgetStateProperty.all(Insets.zero),
            foregroundColor: _foregroundColor(size),
            backgroundColor: _backgroundColor(size),
            elevation: WidgetStateProperty.all(0),
          ),
          child: FlutterBaseIcon(
            icon: icon,
            size: size == ButtonSize.small ? 16 : 24,
          ),
        );

  static WidgetStateProperty<Color?> _foregroundColor(ButtonSize size) {
    return WidgetStateProperty.resolveWith((states) {
      const smallColor = FlutterBaseColors.specificContentHigh;
      const normalColor = FlutterBaseColors.specificSemanticPrimary;

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

  static WidgetStateProperty<Color?> _backgroundColor(ButtonSize size) {
    return WidgetStateProperty.resolveWith((states) {
      const smallColor = FlutterBaseColors.specificSemanticPrimary;
      const normalColor = FlutterBaseColors.specificBasicWhite;

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
