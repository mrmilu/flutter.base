import 'package:flutter/material.dart';

import '../../../utils/styles/text_styles.dart';
import '../../image_asset_widget.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.enabled = true,
    required this.label,
    required this.onPressed,
    this.iconPath,
    this.textStyle = TextStyles.body1,
    this.colorText,
  });
  const CustomTextButton._({
    required this.enabled,
    required this.label,
    required this.onPressed,
    this.iconPath,
    this.textStyle = TextStyles.body1,
    this.colorText,
  });
  final bool enabled;
  final String label;
  final String? iconPath;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onPressed : null,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        foregroundColor: Colors.black,
        overlayColor: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              style: textStyle.copyWith(
                color: enabled ? colorText ?? Colors.black : Colors.grey,
              ),
            ),
          ),
          if (iconPath != null) ...[
            const SizedBox(width: 8),
            ImageAssetWidget(
              path: iconPath!,
              height: 16,
              width: 16,
              color: enabled ? colorText ?? Colors.black : Colors.grey,
            ),
          ],
        ],
      ),
    );
  }

  factory CustomTextButton.icon({
    required String label,
    required String iconPath,
    required VoidCallback onPressed,
    bool enabled = true,
    TextStyle textStyle = TextStyles.body1,
    Color? colorText,
  }) {
    return CustomTextButton._(
      enabled: enabled,
      label: label,
      iconPath: iconPath,
      onPressed: onPressed,
      textStyle: textStyle,
      colorText: colorText,
    );
  }
}
