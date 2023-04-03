import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/icons/flutter_base_icon.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/paddings.dart';
import 'package:flutter_base/ui/view_models/button_size.dart';

const _btnSizeMap = {
  ButtonSize.normal: Size(48, 48),
  ButtonSize.small: Size(32, 32),
};

class IconButtonPrimary extends ElevatedButton {
  IconButtonPrimary({
    super.key,
    required super.onPressed,
    required IconData icon,
    ButtonSize size = ButtonSize.normal,
    Size? fixedSize,
  }) : super(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            minimumSize:
                MaterialStateProperty.all(fixedSize ?? _btnSizeMap[size]),
            fixedSize:
                MaterialStateProperty.all(fixedSize ?? _btnSizeMap[size]),
            maximumSize:
                MaterialStateProperty.all(fixedSize ?? _btnSizeMap[size]),
            enableFeedback: true,
            splashFactory: NoSplash.splashFactory,
            padding: MaterialStateProperty.all(Paddings.zero),
            foregroundColor: _foregroundColor(size),
            backgroundColor: _backgroundColor(size),
            elevation: MaterialStateProperty.all(0),
          ),
          child: Align(
            child: FlutterBaseIcon(
              icon: icon,
              size: size == ButtonSize.small ? 16 : 24,
            ),
          ),
        );

  static MaterialStateProperty<Color?> _foregroundColor(ButtonSize size) {
    return MaterialStateProperty.resolveWith((states) {
      const smallColor = FlutterBaseColors.specificSemanticPrimary;
      const normalColor = FlutterBaseColors.specificBasicWhite;

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
      const smallColor = FlutterBaseColors.specificSurfaceHigh;
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
}
