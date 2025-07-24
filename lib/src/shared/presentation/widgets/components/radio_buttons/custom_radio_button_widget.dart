import 'package:flutter/material.dart';

import '../../row_icon_text_widget.dart';
import '../../text/text_body.dart';

// TODO: Do this widget to use the CustomRadioButtonWidget
class CustomRadioButtonWidget extends StatelessWidget {
  const CustomRadioButtonWidget({
    super.key,
    this.enabled = true,
    this.title,
    required this.text,
    required this.value,
    required this.onChanged,
    this.infoText,
    this.showError = false,
    this.errorText,
  });
  final bool enabled;
  final String? title;
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? infoText;
  final bool showError;
  final String? errorText;

  // Color _getColor() {
  //   if (!enabled) {
  //     return AppColors.specificBasicGrey;
  //   }
  //   if (showError && value) {
  //     return AppColors.specificSemanticError;
  //   }
  //   if (value) {
  //     return AppColors.specificBasicBlack;
  //   }
  //   return AppColors.specificBasicWhite;
  // }

  // Color _getBorderColor() {
  //   if (!enabled) {
  //     return AppColors.specificBasicGrey;
  //   }
  //   if (showError) {
  //     return AppColors.specificSemanticError;
  //   }
  //   return AppColors.specificBasicBlack;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          TextBody.two(title!),
          const SizedBox(height: 6),
        ],
        InkWell(
          onTap: enabled ? () => onChanged(!value) : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  value: value,
                  groupValue: true,
                  onChanged: (value) {
                    onChanged(!this.value);
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  activeColor: Colors.black,
                  title: TextBody.two(text),
                ),
              ),
            ],
          ),
        ),
        if ((errorText != null && showError) || infoText != null) ...[
          const SizedBox(height: 8),
          showError
              ? RowIconTextWidget.warning(
                  errorText!,
                )
              : RowIconTextWidget.info(
                  infoText!,
                ),
        ],
      ],
    );
  }
}
