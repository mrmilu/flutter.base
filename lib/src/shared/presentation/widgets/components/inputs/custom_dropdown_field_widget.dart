import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../../utils/styles/text_styles.dart';
import '../../image_asset_widget.dart';
import '../../row_icon_text_widget.dart';
import '../../text/text_body.dart';

class CustomDropdownFieldWidget<T> extends StatelessWidget {
  const CustomDropdownFieldWidget({
    super.key,
    this.enabled = true,
    this.title,
    this.initialValue,
    required this.onChanged,
    this.infoText,
    this.showError = false,
    this.errorText,
    this.readOnly = false,
    required this.items,
  });
  final bool enabled;
  final String? title;
  final String? initialValue;
  final Function(T) onChanged;
  final String? infoText;
  final bool showError;
  final String? errorText;
  final bool readOnly;

  final List<DropdownMenuItem<T>>? items;

  Color _getBorderColor() {
    if (!enabled || readOnly) {
      return AppColors.specificBasicGrey;
    }
    if (showError) {
      return AppColors.specificSemanticError;
    }
    return AppColors.specificBasicBlack;
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: readOnly,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: readOnly
                  ? AppColors.background
                  : AppColors.specificBasicWhite,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                width: 1,
                color: _getBorderColor(),
              ),
            ),
            alignment: Alignment.center,
            child: Center(
              child: DropdownButtonFormField<T>(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 6,
                  ),
                  border: InputBorder.none,
                  enabled: enabled && !readOnly,
                  label: title != null
                      ? TextBody.two(
                          title!,
                          color: AppColors.specificBasicBlack,
                        )
                      : null,
                  labelStyle: TextStyles.body2,
                ),
                hint: initialValue != null
                    ? TextBody.two(
                        initialValue!,
                        color: enabled && !readOnly
                            ? AppColors.specificBasicBlack
                            : AppColors.grey,
                      )
                    : null,
                icon: Padding(
                  padding: EdgeInsets.only(bottom: title != null ? 10.0 : 0),
                  child: ImageAssetWidget(
                    path: 'assets/icons/arrow_ios_down.svg',
                    color: enabled && !readOnly
                        ? AppColors.specificBasicBlack
                        : AppColors.specificBasicGrey,
                  ),
                ),
                items: items,
                selectedItemBuilder: (context) => items!
                    .map(
                      (item) => Container(
                        alignment: Alignment.center,
                        child: TextBody.two(
                          item.value.toString(),
                          color: readOnly
                              ? AppColors.grey
                              : AppColors.specificBasicBlack,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: enabled
                    ? (e) {
                        if (e != null) {
                          onChanged(e);
                        }
                      }
                    : null,
              ),
            ),
          ),
          if ((errorText != null && showError) || infoText != null) ...[
            const SizedBox(height: 8),
            showError
                ? RowIconTextWidget.error(
                    errorText!,
                  )
                : RowIconTextWidget.info(
                    infoText!,
                  ),
          ],
        ],
      ),
    );
  }
}
