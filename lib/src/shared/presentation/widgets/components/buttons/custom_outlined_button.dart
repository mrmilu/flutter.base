import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../button_scale_widget.dart';
import '../../image_asset_widget.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;
  final bool isLoading;
  final String? iconPath;
  final bool iconRight;
  final TextAlign? textAlign;
  final Widget? iconWidget;

  const CustomOutlinedButton._({
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.iconPath,
    this.iconRight = false,
    this.isLoading = false,
    this.textAlign,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonScaleWidget(
      onTap: () {
        if (isLoading) return;
        onPressed();
      },
      child: OutlinedButton(
        onPressed: () {
          if (isLoading) return;
          onPressed();
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
        ),
        child: isLoading
            ? SizedBox(
                height: 16,
                width: 16,
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
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (!iconRight && iconWidget != null) ...[
                    iconWidget!,
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
                    ),
                  ],
                  if (iconRight && iconWidget != null) ...[
                    iconWidget!,
                    const SizedBox(width: 8),
                  ],
                ],
              ),
      ),
    );
  }

  factory CustomOutlinedButton.primary({
    required String label,
    required VoidCallback onPressed,
    EdgeInsets? padding,
    String? iconPath,
    Color? backgroundColor,
    bool iconRight = false,
    bool isLoading = false,
    TextAlign? textAlign,
    Widget? iconWidget,
  }) {
    return CustomOutlinedButton._(
      label: label,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: AppColors.specificContentHigh,
      padding: padding,
      iconPath: iconPath,
      iconRight: iconRight,
      isLoading: isLoading,
      textAlign: textAlign,
      iconWidget: iconWidget,
    );
  }
}
