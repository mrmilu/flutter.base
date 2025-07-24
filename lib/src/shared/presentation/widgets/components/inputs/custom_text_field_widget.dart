import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/styles/colors.dart';
import '../../../utils/styles/text_styles.dart';
import '../../row_icon_text_widget.dart';
import '../../text/text_body.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
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
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool isLoading;
  final bool isAccepted;
  final bool autoHideKeyboard;
  final bool showBorder;
  const CustomTextFieldWidget({
    super.key,
    this.onSaved,
    required this.onChanged,
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
    this.maxLines = 1,
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
    this.textInputAction,
    this.inputFormatters,
    this.readOnly = false,
    this.isLoading = false,
    this.isAccepted = false,
    this.autoHideKeyboard = true,
    this.showBorder = true,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late FocusNode _focusNode;
  late ValueNotifier<double> _borderWidthNotifier;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _borderWidthNotifier = ValueNotifier(1.0);
    _obscureText = widget.obscureText ?? false;

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
                padding: widget.showBorder
                    ? EdgeInsets.all(borderWidth == 1.8 ? 0 : 0.9)
                    : EdgeInsets.zero,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color:
                        widget.backgroundColor ??
                        (widget.readOnly
                            ? AppColors.background
                            : AppColors.specificBasicWhite),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    border: widget.showBorder
                        ? Border.all(
                            width: borderWidth,
                            color:
                                (widget.showError && widget.errorText != null)
                                ? AppColors.specificSemanticError
                                : widget.borderColor ??
                                      (widget.readOnly
                                          ? AppColors.specificBasicGrey
                                          : AppColors.specificBasicBlack),
                          )
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: widget.enabled && !widget.readOnly,
                              readOnly: widget.readOnly,
                              onTapOutside: widget.autoHideKeyboard
                                  ? (_) {
                                      FocusScope.of(context).unfocus();
                                    }
                                  : null,
                              inputFormatters: widget.inputFormatters,
                              textInputAction: widget.textInputAction,
                              textCapitalization:
                                  widget.textCapitalization ??
                                  TextCapitalization.none,
                              autofocus: widget.autofocus,
                              focusNode: _focusNode,
                              onSaved: widget.onSaved,
                              initialValue: widget.controller == null
                                  ? widget.initialValue
                                  : null,
                              obscureText: _obscureText,
                              onChanged: widget.onChanged,
                              controller: widget.controller,
                              validator: widget.validator,
                              style: widget.textStyle ?? TextStyles.body2,
                              keyboardType: widget.keyboardType,
                              textAlign: widget.textAlign ?? TextAlign.start,
                              maxLines: widget.maxLines,
                              maxLength: widget.maxLength,
                              cursorColor: AppColors.specificBasicBlack,
                              autocorrect: widget.obscureText == true
                                  ? false
                                  : true,
                              enableSuggestions: widget.obscureText == true
                                  ? false
                                  : true,
                              decoration:
                                  widget.decoration ??
                                  InputDecoration(
                                    isDense: true,
                                    filled: false,
                                    border: InputBorder.none,
                                    fillColor: widget.backgroundColor,
                                    prefixIcon: widget.prefixIcon,
                                    suffixIcon: widget.obscureText == true
                                        ? IconButton(
                                            icon: Icon(
                                              _obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: AppColors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                          )
                                        : widget.suffixIcon,
                                    label: widget.labelText != null
                                        ? TextBody.two(
                                            widget.labelText!,
                                            color: widget.enabled
                                                ? AppColors.specificBasicBlack
                                                : AppColors.grey,
                                          )
                                        : null,
                                    contentPadding:
                                        widget.contentPadding ??
                                        const EdgeInsets.only(top: 0),
                                    counterStyle: const TextStyle(
                                      color: AppColors.grey,
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
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          if (widget.isAccepted)
                            const Icon(
                              Icons.check,
                              color: AppColors.specificSemanticSuccess,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if ((widget.showError && widget.errorText != null) ||
              widget.infoText != null) ...[
            const SizedBox(height: 6),
            widget.showError && widget.errorText != null
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
