import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/extensions/buildcontext_extensions.dart';
import '../../../utils/styles/colors.dart';
import '../../common/custom_row_icon_text_widget.dart';
import '../text/rm_text.dart';

class CustomStatesTextFieldWidget extends StatefulWidget {
  final Function(String) onCompleted;
  final Function(String)? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final String? labelText;
  final EdgeInsets? padding;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? prefixText;
  final TextEditingController? controller;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? borderColor;
  final int? maxLines;
  final int? maxLength;
  final bool autofocus;
  final double borderRadius;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final TextCapitalization? textCapitalization;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final String? errorText;
  final bool showError;
  final String? infoText;
  final bool isLoading;
  final bool isAccepted;
  final bool isError;
  final List<TextInputFormatter>? inputFormatters;
  final int limitOnCompleted;

  const CustomStatesTextFieldWidget({
    super.key,
    required this.onCompleted,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.hintText,
    required this.labelText,
    this.obscureText,
    this.padding,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.prefixText,
    this.initialValue = '',
    this.borderColor,
    this.maxLines,
    this.maxLength,
    this.autofocus = false,
    this.borderRadius = 32,
    this.focusNode,
    this.decoration,
    this.textAlign,
    this.textStyle,
    this.backgroundColor,
    this.textCapitalization,
    this.enabled = true,
    this.contentPadding,
    this.errorText,
    this.showError = false,
    this.infoText,
    this.isLoading = false,
    this.isAccepted = false,
    this.isError = false,
    this.inputFormatters,
    this.limitOnCompleted = 28,
  });

  @override
  State<CustomStatesTextFieldWidget> createState() =>
      _CustomStatesTextFieldWidgetState();
}

class _CustomStatesTextFieldWidgetState
    extends State<CustomStatesTextFieldWidget> {
  late final TextEditingController _controller;
  late FocusNode _focusNode;
  late ValueNotifier<double> _borderWidthNotifier;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);

    _focusNode = widget.focusNode ?? FocusNode();
    _borderWidthNotifier = ValueNotifier(1.0);

    _focusNode.addListener(() {
      _borderWidthNotifier.value = _focusNode.hasFocus ? 1.8 : 1.0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _borderWidthNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<double>(
            valueListenable: _borderWidthNotifier,
            builder: (context, borderWidth, child) {
              return Padding(
                padding: EdgeInsets.all(borderWidth == 1.8 ? 0 : 0.9),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color:
                        widget.backgroundColor ?? AppColors.specificBasicWhite,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    border: Border.all(
                      width: borderWidth,
                      color: widget.showError
                          ? AppColors.specificSemanticError
                          : widget.borderColor ?? AppColors.specificBasicBlack,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: widget.enabled,
                              inputFormatters: widget.inputFormatters,
                              maxLengthEnforcement: MaxLengthEnforcement
                                  .truncateAfterCompositionEnds,
                              textCapitalization:
                                  widget.textCapitalization ??
                                  TextCapitalization.none,
                              autofocus: widget.autofocus,
                              focusNode: _focusNode,
                              onSaved: widget.onSaved,
                              obscureText: widget.obscureText ?? false,
                              onChanged: (text) {
                                widget.onChanged?.call(text);
                                if (text.length == widget.limitOnCompleted) {
                                  widget.onCompleted(text);
                                }
                              },
                              controller: _controller,
                              validator: widget.validator,
                              style:
                                  widget.textStyle ??
                                  context.textTheme.bodyMedium?.copyWith(
                                    color: widget.isError
                                        ? AppColors.specificSemanticError
                                        : AppColors.specificBasicBlack,
                                  ),
                              keyboardType: widget.keyboardType,
                              textAlign: widget.textAlign ?? TextAlign.start,
                              maxLines: widget.maxLines ?? 1,
                              maxLength: widget.maxLength,
                              cursorColor: AppColors.specificBasicBlack,
                              decoration:
                                  widget.decoration ??
                                  InputDecoration(
                                    isDense: true,
                                    filled: false,
                                    prefix: widget.prefixText != null
                                        ? RMText.bodyMedium(
                                            widget.prefixText!,
                                            color: widget.enabled
                                                ? AppColors.specificBasicBlack
                                                : AppColors.specificBasicGrey,
                                          )
                                        : null,
                                    border: InputBorder.none,
                                    fillColor: widget.backgroundColor,
                                    prefixIcon: widget.prefixIcon,
                                    suffixIcon: widget.suffixIcon,
                                    label: widget.labelText != null
                                        ? RMText.bodyMedium(
                                            widget.labelText!,
                                            color: widget.enabled
                                                ? AppColors.specificBasicBlack
                                                : AppColors.specificBasicGrey,
                                          )
                                        : null,
                                    contentPadding:
                                        widget.contentPadding ??
                                        const EdgeInsets.only(top: 0),
                                    counterStyle: const TextStyle(
                                      color: AppColors.specificBasicGrey,
                                    ),
                                    suffixIconConstraints: const BoxConstraints(
                                      maxWidth: 60,
                                      maxHeight: 25,
                                    ),
                                    prefixText: widget.prefixText,
                                    hintText: widget.hintText,
                                  ),
                            ),
                          ),
                          if (widget.isLoading)
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          if (widget.isAccepted)
                            const Icon(
                              Icons.check,
                              color: AppColors.specificSemanticSuccess,
                            ),
                          if (widget.isError)
                            const Icon(
                              Icons.error,
                              color: AppColors.specificSemanticError,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (widget.showError || widget.infoText != null) ...[
            const SizedBox(height: 6),
            widget.showError
                ? CustomRowIconTextWidget.warning(widget.errorText!)
                : CustomRowIconTextWidget.info(widget.infoText!),
          ],
        ],
      ),
    );
  }
}
