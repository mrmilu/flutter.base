import 'package:flutter/material.dart';

import '../../../utils/styles/app_assets.dart';
import '../../../utils/styles/colors.dart';
import '../../common/custom_row_icon_text_widget.dart';
import '../../common/image_asset_widget.dart';
import '../text/rm_text.dart';

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
    this.value,
    required this.items,
    this.borderRadius = 32.0,
    this.forzeBlackColor = false,
  });
  final bool enabled;
  final String? title;
  final String? initialValue;
  final Function(T) onChanged;
  final String? infoText;
  final bool showError;
  final String? errorText;
  final bool readOnly;
  final double borderRadius;
  final bool forzeBlackColor;

  final T? value;
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
                  ? AppColors.specificBasicGrey
                  : AppColors.specificBasicWhite,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(width: 1, color: _getBorderColor()),
            ),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: title != null ? 6 : 8),
                if (title != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: RMText.labelSmall(
                      title!,
                      color: AppColors.specificBasicBlack,
                    ),
                  ),
                ],
                SizedBox(
                  height: 28,
                  child: LayoutBuilder(
                    builder: (context, constrain) {
                      return DropdownButton<T>(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        isDense: true,
                        menuWidth: constrain.maxWidth,
                        borderRadius: BorderRadius.circular(8),
                        menuMaxHeight: 320,
                        hint: initialValue != null
                            ? RMText.bodyMedium(
                                initialValue!,
                                color: enabled && !readOnly
                                    ? AppColors.specificBasicBlack
                                    : AppColors.specificBasicGrey,
                              )
                            : null,
                        icon: Padding(
                          padding: EdgeInsets.only(
                            right: 16.0,
                            bottom: title != null ? 16.0 : 0,
                          ),
                          child: ImageAssetWidget(
                            path: AppAssets.iconArrowDown,
                            color: enabled && !readOnly
                                ? AppColors.specificBasicBlack
                                : AppColors.specificBasicGrey,
                          ),
                        ),
                        items: items,
                        value: value,
                        selectedItemBuilder: (context) => items!
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  bottom: 4,
                                ),
                                child: RMText.bodyMedium(
                                  initialValue ?? value.toString(),
                                  color: readOnly
                                      ? forzeBlackColor
                                            ? AppColors.specificBasicBlack
                                            : null
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
                      );
                    },
                  ),
                ),
                if (title == null) const SizedBox(height: 8),
              ],
            ),
          ),
          if ((errorText != null && showError) || infoText != null) ...[
            const SizedBox(height: 8),
            showError
                ? CustomRowIconTextWidget.error(errorText!)
                : CustomRowIconTextWidget.info(infoText!),
          ],
        ],
      ),
    );
  }
}
