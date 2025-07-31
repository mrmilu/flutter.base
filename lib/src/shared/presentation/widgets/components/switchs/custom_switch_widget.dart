import 'package:flutter/material.dart';

import '../../../utils/extensions/buildcontext_extensions.dart';
import '../../../utils/styles/colors.dart';
import '../../common/custom_row_icon_text_widget.dart';
import '../text/rm_text.dart';

class CustomSwitchWidget extends StatelessWidget {
  const CustomSwitchWidget({
    super.key,
    this.enabled = true,
    this.title,
    required this.text,
    this.textStyle,
    required this.value,
    required this.onChanged,
    this.infoText,
    this.showError = false,
    this.errorText,
    this.switchLeft = true,
    this.withSpanded = false,
  });
  final bool enabled;
  final String? title;
  final String text;
  final TextStyle? textStyle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? infoText;
  final bool showError;
  final String? errorText;
  final bool switchLeft;
  final bool withSpanded;

  Color _getBackgroundColorActive() {
    if (!enabled) {
      return AppColors.disabled;
    }
    if (showError) {
      return AppColors.specificSemanticError;
    }
    if (value) {
      return AppColors.specificSemanticSuccess;
    }
    return AppColors.specificSemanticSuccess;
  }

  Color _getBackgroundColorInactive() {
    if (!enabled) {
      return AppColors.disabled;
    }
    if (showError) {
      return AppColors.specificSemanticError;
    }
    if (value) {
      return AppColors.specificBasicSemiBlack;
    }
    return AppColors.specificBasicSemiBlack;
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
        InkWell(
          onTap: enabled ? () => onChanged(!value) : null,
          child: Row(
            children: [
              if (switchLeft) ...[
                SizedBox(
                  height: 28,
                  width: 40,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Switch(
                      activeColor: Colors.white,
                      activeTrackColor: _getBackgroundColorActive(),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: _getBackgroundColorInactive(),
                      trackOutlineColor:
                          WidgetStateProperty.resolveWith<Color?>((
                            Set<WidgetState> states,
                          ) {
                            return Colors.transparent;
                          }),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                        Set<WidgetState> states,
                      ) {
                        return const Icon(Icons.abc, color: Colors.white);
                      }),
                      padding: EdgeInsets.zero,
                      value: value,
                      onChanged: enabled ? onChanged : null,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              withSpanded
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          text,
                          style: textStyle ?? context.textTheme.bodyMedium,
                        ),
                      ),
                    )
                  : Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          text,
                          style: textStyle ?? context.textTheme.bodyMedium,
                        ),
                      ),
                    ),
              if (!switchLeft) ...[
                const SizedBox(width: 8),
                SizedBox(
                  height: 28,
                  width: 40,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Switch(
                      activeColor: Colors.white,
                      activeTrackColor: _getBackgroundColorActive(),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: _getBackgroundColorInactive(),
                      trackOutlineColor:
                          WidgetStateProperty.resolveWith<Color?>((
                            Set<WidgetState> states,
                          ) {
                            return Colors.transparent;
                          }),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                        Set<WidgetState> states,
                      ) {
                        return const Icon(Icons.abc, color: Colors.white);
                      }),
                      padding: EdgeInsets.zero,
                      value: value,
                      onChanged: enabled ? onChanged : null,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if ((errorText != null && showError) || infoText != null) ...[
          const SizedBox(height: 4),
          showError
              ? CustomRowIconTextWidget.warning(errorText!)
              : CustomRowIconTextWidget.info(infoText!),
        ],
      ],
    );
  }
}
