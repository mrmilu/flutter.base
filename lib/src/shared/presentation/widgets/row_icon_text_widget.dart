import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../utils/styles/colors.dart';
import '../utils/styles/text_styles.dart';
import 'image_asset_widget.dart';

class RowIconTextWidget extends StatelessWidget {
  const RowIconTextWidget({
    super.key,
    required this.text,
    this.textStyle,
    this.iconPath,
    this.iconSize = 16,
    this.iconColor,
    this.spacing = 4.0,
  });
  final String text;
  final TextStyle? textStyle;
  final String? iconPath;
  final double iconSize;
  final Color? iconColor;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (iconPath != null) ...[
          Skeleton.shade(
            child: ImageAssetWidget(
              path: iconPath!,
              width: iconSize,
              height: iconSize,
              color: iconColor,
            ),
          ),
          SizedBox(width: spacing),
        ],
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Text(
              text,
              style: textStyle ?? TextStyles.caption1,
            ),
          ),
        ),
      ],
    );
  }

  factory RowIconTextWidget.info(String text) {
    return RowIconTextWidget(
      text: text,
      iconPath: 'assets/icons/top_bar_info.svg',
      iconSize: 16,
      iconColor: AppColors.specificBasicBlack,
    );
  }

  factory RowIconTextWidget.warning(String text, {Color? textColor}) {
    return RowIconTextWidget(
      text: text,
      iconPath: 'assets/icons/warning.svg',
      iconSize: 16,
      iconColor: AppColors.specificSemanticWarning,
      textStyle: TextStyles.caption1.copyWith(
        color: textColor ?? AppColors.specificSemanticWarning,
      ),
    );
  }

  factory RowIconTextWidget.error(String text, {Color? textColor}) {
    return RowIconTextWidget(
      text: text,
      iconPath: 'assets/icons/warning.svg',
      iconSize: 16,
      iconColor: AppColors.specificSemanticError,
      textStyle: TextStyles.caption1.copyWith(
        color: textColor ?? AppColors.specificSemanticError,
      ),
    );
  }
}
