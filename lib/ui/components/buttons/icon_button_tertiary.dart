import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/icons/flutter_base_icon.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/insets.dart';
import 'package:flutter_base/ui/view_models/button_size.dart';

const _btnSizeMap = {
  ButtonSize.normal: Size(48, 48),
  ButtonSize.small: Size(32, 32),
};

class IconButtonTertiary extends TextButton {
  IconButtonTertiary({
    super.key,
    required IconData icon,
    ButtonSize? size,
    Color? foregroundColor = FlutterBaseColors.specificSemanticPrimary,
    Size? fixedSize,
    required super.onPressed,
  }) : super(
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            splashFactory: NoSplash.splashFactory,
            padding: Insets.zero,
            minimumSize: fixedSize ?? _btnSizeMap[size],
            fixedSize: fixedSize ?? _btnSizeMap[size],
            maximumSize: fixedSize ?? _btnSizeMap[size],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            visualDensity: VisualDensity.compact,
          ),
          child: FlutterBaseIcon(
            icon: icon,
            size: size == ButtonSize.small ? 16 : 24,
          ),
        );
}
