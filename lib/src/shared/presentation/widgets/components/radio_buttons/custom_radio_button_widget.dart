import 'package:flutter/material.dart';

import '../../common/custom_row_icon_text_widget.dart';
import '../text/rm_text.dart';

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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          RMText.bodyMedium(title!),
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
                  onChanged: enabled
                      ? (value) {
                          onChanged(!this.value);
                        }
                      : null,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  activeColor: isDarkMode ? Colors.white : Colors.black,
                  title: RMText.bodyMedium(text),
                ),
              ),
            ],
          ),
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
