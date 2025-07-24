import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../image_asset_widget.dart';
import '../../text/text_body.dart';

class CustomTagIconWidget extends StatelessWidget {
  const CustomTagIconWidget({
    super.key,
    required this.label,
    this.textColor,
    this.backgroundColor = AppColors.background,
    this.borderColor,
    required this.iconPath,
    this.iconColor,
  });
  final String label;
  final Color? textColor;
  final Color backgroundColor;
  final Color? borderColor;
  final String iconPath;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      constraints: const BoxConstraints(
        minWidth: 88,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(80),
        border: Border.all(
          width: 1,
          color: borderColor ?? backgroundColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageAssetWidget(
            path: iconPath,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: TextBody.two(
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
    Color backgroundColor = AppColors.background,
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

  factory CustomTagIconWidget.outlined({
    required String label,
    required String iconPath,
    Color? textColor,
    Color borderColor = AppColors.specificBasicGrey,
    Color backgroundColor = AppColors.background,
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
