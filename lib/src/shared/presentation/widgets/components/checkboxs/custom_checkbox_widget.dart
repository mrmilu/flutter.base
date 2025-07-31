import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../common/custom_row_icon_text_widget.dart';
import '../text/rm_text.dart';

class CustomCheckboxWidget extends StatelessWidget {
  const CustomCheckboxWidget({
    super.key,
    this.enabled = true,
    this.title,
    required this.textCheckbox,
    required this.value,
    required this.onChanged,
    this.infoText,
    this.showError = false,
    this.errorText,
    this.childContent,
  });
  final bool enabled;
  final String? title;
  final String textCheckbox;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? infoText;
  final bool showError;
  final String? errorText;
  final Widget? childContent;

  Color _getColor() {
    if (!enabled) {
      return AppColors.disabled;
    }
    if (showError && value) {
      return AppColors.specificSemanticError;
    }
    if (value) {
      return AppColors.specificBasicBlack;
    }
    return AppColors.specificBasicWhite;
  }

  Color _getBorderColor() {
    if (!enabled) {
      return AppColors.disabled;
    }
    if (showError) {
      return AppColors.specificSemanticError;
    }
    return AppColors.specificBasicBlack;
  }

  Color _getColorCheck() {
    if (!enabled) {
      return AppColors.specificBasicBlack;
    }
    if (showError) {
      return AppColors.specificBasicWhite;
    }
    if (value) {
      return AppColors.specificBasicWhite;
    }
    return AppColors.specificBasicWhite;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          RMText.bodyMedium(title!),
          const SizedBox(height: 6),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: enabled ? () => onChanged(!value) : null,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    color: _getColor(),
                    border: Border.all(color: _getBorderColor()),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: value
                      ? Icon(Icons.check, size: 12, color: _getColorCheck())
                      : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child:
                  childContent ??
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: RMText.bodyMedium(textCheckbox),
                  ),
            ),
          ],
        ),
        if ((errorText != null && showError) || infoText != null) ...[
          const SizedBox(height: 8),
          showError
              ? CustomRowIconTextWidget.error(errorText!)
              : CustomRowIconTextWidget.info(infoText!),
        ],
      ],
    );
  }
}
