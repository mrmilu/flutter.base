import 'package:flutter/material.dart';

import '../../utils/extensions/buildcontext_extensions.dart';
import '../../utils/styles/app_assets.dart';
import '../../utils/styles/colors.dart';
import 'image_asset_widget.dart';

class CustomRowIconTextWidget extends StatelessWidget {
  const CustomRowIconTextWidget({
    super.key,
    required this.text,
    this.textStyle,
    this.iconPath,
    this.iconSize = 16,
    this.iconColor,
    this.textColor,
    this.spacing = 4.0,
  });
  final String text;
  final TextStyle? textStyle;
  final String? iconPath;
  final double iconSize;
  final Color? iconColor;
  final Color? textColor;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (iconPath != null) ...[
          ImageAssetWidget(
            path: iconPath!,
            width: iconSize,
            height: iconSize,
            color:
                iconColor ??
                (brightness == Brightness.dark ? Colors.white : Colors.black),
          ),
          SizedBox(width: spacing),
        ],
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Text(
              text,
              style:
                  textStyle ??
                  context.textTheme.labelSmall?.copyWith(
                    color: textColor,
                  ) ??
                  TextStyle(color: textColor),
            ),
          ),
        ),
      ],
    );
  }

  const CustomRowIconTextWidget.info(
    this.text, {
    super.key,
  }) : iconPath = AppAssets.iconInfo,
       iconSize = 16,
       iconColor = null,
       textColor = null,
       textStyle = null,
       spacing = 4.0;

  const CustomRowIconTextWidget.warning(
    this.text, {
    super.key,
    this.textColor = AppColors.specificSemanticWarning,
  }) : iconPath = AppAssets.iconWarning,
       iconSize = 16,
       iconColor = AppColors.specificSemanticWarning,
       textStyle = null,
       spacing = 4.0;

  const CustomRowIconTextWidget.error(
    this.text, {
    super.key,
    this.textColor = AppColors.specificSemanticError,
  }) : iconPath = AppAssets.iconError,
       iconSize = 16,
       iconColor = AppColors.specificSemanticError,
       textStyle = null,
       spacing = 4.0;
}
