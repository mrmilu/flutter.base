import 'package:flutter/material.dart';

import '../../../utils/styles/colors/colors_context.dart';
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

  Color _getColor(BuildContext context) {
    if (!enabled) {
      return context.colors.disabled;
    }
    if (showError && value) {
      return context.colors.specificSemanticError;
    }
    if (value) {
      return context.colors.specificBasicBlack;
    }
    return context.colors.specificBasicWhite;
  }

  Color _getBorderColor(BuildContext context) {
    if (!enabled) {
      return context.colors.disabled;
    }
    if (showError) {
      return context.colors.specificSemanticError;
    }
    return context.colors.specificBasicBlack;
  }

  Color _getColorCheck(BuildContext context) {
    if (!enabled) {
      return context.colors.specificBasicBlack;
    }
    if (showError) {
      return context.colors.specificBasicWhite;
    }
    return context.colors.specificBasicWhite;
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
                    color: _getColor(context),
                    border: Border.all(color: _getBorderColor(context)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: value
                      ? Icon(
                          Icons.check,
                          size: 12,
                          color: _getColorCheck(context),
                        )
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
              ? CustomRowIconTextWidget.error(errorText!, context: context)
              : CustomRowIconTextWidget.info(infoText!, context: context),
        ],
      ],
    );
  }
}
