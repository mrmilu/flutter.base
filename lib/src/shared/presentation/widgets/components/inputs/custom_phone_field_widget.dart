import 'package:flutter/material.dart';

import '../../../../domain/types/prefix_phone_type.dart';
import '../../../utils/styles/colors.dart';
import '../../../utils/styles/text_styles.dart';
import '../../image_asset_widget.dart';
import '../../row_icon_text_widget.dart';
import '../../text/text_body.dart';
import 'custom_text_field_widget.dart';
import 'phone_input_formatter.dart';

class CustomPhoneFieldWidget<T> extends StatefulWidget {
  const CustomPhoneFieldWidget({
    super.key,
    this.enabled = true,
    this.title,
    required this.initialValue,
    this.initialPhoneValue,
    required this.onChangedPrefix,
    this.infoText,
    this.showError = false,
    this.errorText,
    this.readOnly = false,
    this.focusNode,
    this.inputLabel,
    this.onChangedPhone,
  });
  final bool enabled;
  final String? title;
  final PrefixPhoneType initialValue;
  final String? initialPhoneValue;
  final Function(PrefixPhoneType) onChangedPrefix;
  final String? infoText;
  final bool showError;
  final String? errorText;
  final bool readOnly;
  final FocusNode? focusNode;
  final String? inputLabel;
  final ValueChanged<String>? onChangedPhone;

  @override
  State<CustomPhoneFieldWidget<T>> createState() =>
      _CustomPhoneFieldWidgetState<T>();
}

class _CustomPhoneFieldWidgetState<T> extends State<CustomPhoneFieldWidget<T>> {
  late FocusNode _focusNode;
  late ValueNotifier<double> _borderWidthNotifier;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _borderWidthNotifier = ValueNotifier(1.0);

    _focusNode.addListener(() {
      _borderWidthNotifier.value = _focusNode.hasFocus ? 1.8 : 1.0;
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _borderWidthNotifier.dispose();
    super.dispose();
  }

  Color _getBorderColor() {
    if (!widget.enabled || widget.readOnly) {
      return AppColors.specificBasicGrey;
    }
    if (widget.showError) {
      return AppColors.specificSemanticError;
    }
    return AppColors.specificBasicBlack;
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.readOnly,
      child: Column(
        children: [
          ValueListenableBuilder<double>(
            valueListenable: _borderWidthNotifier,
            builder: (context, borderWidth, child) {
              return Container(
                decoration: BoxDecoration(
                  color: widget.readOnly
                      ? AppColors.background
                      : AppColors.specificBasicWhite,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    width: borderWidth,
                    color: _getBorderColor(),
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(
                      width: 90,
                      child: DropdownButton<PrefixPhoneType>(
                        isExpanded: true,
                        menuWidth: 240,
                        style: TextStyles.body2.copyWith(
                          color: AppColors.specificBasicBlack,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        underline: const SizedBox.shrink(),
                        hint: Container(
                          alignment: Alignment.center,
                          child: TextBody.two(
                            widget.initialValue.prefix,
                            color: widget.enabled && !widget.readOnly
                                ? AppColors.specificBasicBlack
                                : AppColors.grey,
                          ),
                        ),
                        icon: ImageAssetWidget(
                          path: 'assets/icons/arrow_ios_down.svg',
                          color: widget.enabled && !widget.readOnly
                              ? AppColors.specificBasicBlack
                              : AppColors.specificBasicGrey,
                        ),
                        items: PrefixPhoneType.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: TextBody.two(
                                  '${e.toTranslate(context)} (${e.prefix})',
                                  color: e.code != widget.initialValue.code
                                      ? AppColors.specificBasicBlack
                                      : AppColors.grey,
                                ),
                              ),
                            )
                            .toList(),
                        selectedItemBuilder: (context) => PrefixPhoneType.values
                            .map(
                              (item) => Container(
                                alignment: Alignment.center,
                                child: TextBody.two(
                                  item.prefix,
                                  color: widget.readOnly
                                      ? AppColors.grey
                                      : AppColors.specificBasicBlack,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: widget.enabled
                            ? (e) {
                                if (e != null) {
                                  widget.onChangedPrefix(e);
                                }
                              }
                            : null,
                      ),
                    ),
                    Container(
                      width: borderWidth,
                      height: borderWidth == 1.8 ? 52.8 : 54.8,
                      color: AppColors.specificBasicBlack,
                    ),
                    Expanded(
                      child: CustomTextFieldWidget(
                        initialValue: widget.initialPhoneValue,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          PhoneInputFormatter(widget.initialValue.mask),
                        ],
                        onChanged: widget.onChangedPhone,
                        labelText: widget.inputLabel,
                        showBorder: false,
                        focusNode: _focusNode,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          if ((widget.errorText != null && widget.showError) ||
              widget.infoText != null) ...[
            const SizedBox(height: 8),
            widget.showError
                ? RowIconTextWidget.error(
                    widget.errorText!,
                  )
                : RowIconTextWidget.info(
                    widget.infoText!,
                  ),
          ],
        ],
      ),
    );
  }
}
