import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/icons/flutter_base_icon.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/view_models/button_size.dart';

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
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(_btnSizeMap[size]),
            fixedSize: MaterialStateProperty.all(_btnSizeMap[size]),
            maximumSize: MaterialStateProperty.all(_btnSizeMap[size]),
            enableFeedback: true,
            splashFactory: NoSplash.splashFactory,
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            foregroundColor: _foregroundColor(size),
            backgroundColor: _backgroundColor(size),
            elevation: MaterialStateProperty.all(0),
          ),
          child: FlutterBaseIcon(
            icon: icon,
            size: size == ButtonSize.small ? 16 : 24,
          ),
        );

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
