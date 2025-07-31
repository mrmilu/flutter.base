import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../common/image_asset_widget.dart';
import '../text/rm_text.dart';

class CustomTagIconWidget extends StatelessWidget {
  const CustomTagIconWidget({
    super.key,
    required this.label,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    required this.iconPath,
    this.iconColor,
  });

  final String label;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final String iconPath;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    Color? effectiveBorderColor = borderColor;
    if (borderColor == null && backgroundColor == null) {
      final brightness = Theme.of(context).brightness;
      effectiveBorderColor = brightness == Brightness.dark
          ? Colors.white
          : Colors.black;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      constraints: const BoxConstraints(minWidth: 88),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(80),
        border: effectiveBorderColor != null || backgroundColor != null
            ? Border.all(
                width: 1,
                color:
                    effectiveBorderColor ??
                    backgroundColor ??
                    AppColors.background,
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageAssetWidget(
            path: iconPath,
            width: 24,
            height: 24,
            color: iconColor,
            useThemeColor: iconColor == null,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: RMText.bodyMedium(
              label,
              color: textColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  factory CustomTagIconWidget.fill({
    required String label,
    required String iconPath,
    Color? textColor,
    Color? borderColor,
    Color? backgroundColor,
    Color? iconColor,
  }) {
    return CustomTagIconWidget(
      label: label,
      iconPath: iconPath,
      textColor: textColor,
      backgroundColor: backgroundColor ?? Colors.transparent,
      borderColor: borderColor,
      iconColor: iconColor,
    );
  }

  factory CustomTagIconWidget.outlined({
    required String label,
    required String iconPath,
    Color? textColor,
    Color? borderColor,
    Color? backgroundColor,
    Color? iconColor,
  }) {
    return CustomTagIconWidget(
      label: label,
      iconPath: iconPath,
      textColor: textColor,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      iconColor: iconColor,
    );
  }
}
