import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../button_scale_widget.dart';
import '../../image_asset_widget.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;
  final bool isDisabled;
  final bool isLoading;
  final String? iconPath;
  final bool iconRight;
  final TextAlign? textAlign;
  final Color? iconColor;

  const CustomElevatedButton._({
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.isDisabled = false,
    this.isLoading = false,
    this.iconPath,
    this.iconRight = false,
    this.textAlign,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonScaleWidget(
      onTap: isDisabled
          ? null
          : () {
              if (isLoading) return;
              onPressed();
            },
      child: ElevatedButton(
        onPressed: () {
          if (isLoading || isDisabled) return;
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled
              ? AppColors.specificBasicGrey
              : backgroundColor,
          foregroundColor: isDisabled
              ? AppColors.specificBasicWhite
              : foregroundColor,
          padding: padding,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foregroundColor ?? AppColors.specificBasicWhite,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!iconRight && iconPath != null) ...[
                    ImageAssetWidget(
                      path: iconPath!,
                      width: 20,
                      height: 20,
                      color: iconColor,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      textAlign: textAlign,
                    ),
                  ),
                  if (iconRight && iconPath != null) ...[
                    const SizedBox(width: 8),
                    ImageAssetWidget(
                      path: iconPath!,
                      width: 20,
                      height: 20,
                      color: iconColor,
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  factory CustomElevatedButton.primary({
    required String label,
    required VoidCallback onPressed,
    EdgeInsets? padding,
    bool isDisabled = false,
    bool isLoading = false,
    String? iconPath,
    bool iconRight = false,
    TextAlign? textAlign,
  }) {
    return CustomElevatedButton._(
      label: label,
      onPressed: onPressed,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.specificContentHigh,
      padding: padding,
      isDisabled: isDisabled,
      isLoading: isLoading,
      iconPath: iconPath,
      iconRight: iconRight,
      textAlign: textAlign,
      iconColor: AppColors.specificBasicBlack,
    );
  }

  factory CustomElevatedButton.inverse({
    required String label,
    required VoidCallback onPressed,
    EdgeInsets? padding,
    bool isDisabled = false,
    bool isLoading = false,
    String? iconPath,
    bool iconRight = false,
    TextAlign? textAlign,
    Color? backgroundColor,
  }) {
    return CustomElevatedButton._(
      label: label,
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? AppColors.onBackground,
      foregroundColor: AppColors.specificBasicWhite,
      padding: padding,
      isDisabled: isDisabled,
      isLoading: isLoading,
      iconPath: iconPath,
      iconRight: iconRight,
      textAlign: textAlign,
      iconColor: AppColors.specificBasicWhite,
    );
  }
}
