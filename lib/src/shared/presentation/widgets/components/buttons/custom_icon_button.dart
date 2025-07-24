import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../image_asset_widget.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton._({
    required this.onPressed,
    required this.iconPath,
    this.enabled = true,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  final bool enabled;
  final bool isLoading;
  final String iconPath;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onPressed : null,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        minimumSize: const Size(12, 12),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: Colors.black,
        overlayColor: Colors.transparent,
        backgroundColor: enabled
            ? backgroundColor
            : AppColors.specificBasicGrey,
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
          : ImageAssetWidget(
              path: iconPath,
              height: 20,
              width: 20,
              color: enabled ? foregroundColor : Colors.grey,
            ),
    );
  }

  factory CustomIconButton.inverse({
    required String iconPath,
    required VoidCallback onPressed,
    bool enabled = true,
    bool isLoading = false,
  }) {
    return CustomIconButton._(
      enabled: enabled,
      iconPath: iconPath,
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    );
  }
}
