import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../utils/assets/app_assets_icons.dart';
import '../../../utils/styles/colors/colors_context.dart';
import '../../common/custom_row_icon_text_widget.dart';
import '../../common/image_asset_widget.dart';
import '../text/rm_text.dart';

class CustomDropdownFieldPackageWidget<T> extends StatelessWidget {
  const CustomDropdownFieldPackageWidget({
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
  });
  final bool enabled;
  final String? title;
  final String? initialValue;
  final Function(T) onChanged;
  final String? infoText;
  final bool showError;
  final String? errorText;
  final bool readOnly;
  final T? value;

  final List<DropdownMenuItem<T>>? items;

  Color _getBorderColor(BuildContext context) {
    if (!enabled || readOnly) {
      return context.colors.specificBasicGrey;
    }
    if (showError) {
      return context.colors.specificSemanticError;
    }
    return context.colors.specificBasicBlack;
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;
    return Builder(
      builder: (context) {
        return IgnorePointer(
          ignoring: readOnly,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: readOnly
                      ? isDarkMode
                            ? context.colors.grey
                            : context.colors.specificBasicGrey
                      : context.colors.specificBasicWhite,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    width: 1,
                    color: _getBorderColor(context),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: RMText.labelSmall(
                        title!,
                        color: context.colors.specificBasicBlack,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SizedBox(
                        height: 28,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<T>(
                            isDense: true,
                            iconStyleData: IconStyleData(
                              icon: Padding(
                                padding: const EdgeInsets.only(
                                  right: 12.0,
                                  bottom: 16,
                                ),
                                child: ImageAssetWidget(
                                  path: AppAssetsIcons.arrowIosDown,
                                  color: enabled && !readOnly
                                      ? context.colors.specificBasicBlack
                                      : context.colors.specificBasicGrey,
                                ),
                              ),
                            ),
                            items: items,
                            value: value,
                            selectedItemBuilder: (context) => items!
                                .map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 2.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: RMText.bodyMedium(
                                        initialValue ?? value.toString(),
                                        color: readOnly
                                            ? context.colors.specificBasicBlack
                                            : context.colors.specificBasicBlack,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: enabled
                                ? (e) {
                                    if (e != null && e != value) {
                                      onChanged(e);
                                    }
                                  }
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if ((errorText != null && showError) || infoText != null) ...[
                const SizedBox(height: 8),
                showError
                    ? CustomRowIconTextWidget.error(
                        errorText!,
                        context: context,
                      )
                    : CustomRowIconTextWidget.info(infoText!, context: context),
              ],
            ],
          ),
        );
      },
    );
  }
}
