import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/flutter_base_icon.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/moggie_icons.dart';
import 'package:flutter_base/ui/utils/scroll.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InputReactive<T> extends ReactiveTextField {
  InputReactive({
    String? label,
    String? placeholder,
    String? helperText,
    bool withFloatingLabel = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    BoxConstraints? suffixIconConstraints,
    BoxConstraints? prefixIconConstraints,
    ShowErrorsFunction? showErrors,
    super.obscureText,
    super.onSubmitted,
    super.formControl,
    super.formControlName,
    super.key,
    super.keyboardType,
    super.textCapitalization,
    super.validationMessages,
    super.inputFormatters,
    super.readOnly,
  })  : assert(
            ((label != null && withFloatingLabel) && placeholder == null) ||
                ((label == null && !withFloatingLabel) && placeholder != null),
            'At least a placeholder or label should be given'),
        super(
          showErrors: showErrors ??
              (control) => control.invalid && control.touched && control.dirty,
          decoration: InputDecoration(
            hintText: placeholder,
            isDense: true,
            labelText: withFloatingLabel ? label : null,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            suffixIconConstraints: suffixIconConstraints,
            prefixIconConstraints: prefixIconConstraints,
            errorMaxLines: 3,
            floatingLabelBehavior: withFloatingLabel
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.never,
            helperText: helperText,
          ),
          scrollPadding: textFieldScrollPadding(),
        );

  factory InputReactive.email({
    String? label,
    FormControl<T>? formControl,
    String? placeholder,
    ReactiveFormFieldCallback? onSubmitted,
  }) {
    return InputReactive<T>(
        label: label,
        formControl: formControl,
        keyboardType: TextInputType.emailAddress,
        onSubmitted: onSubmitted,
        placeholder: placeholder);
  }

  factory InputReactive.search({
    String? label,
    FormControl<T>? formControl,
    String? formControlName,
    String? placeholder,
    ReactiveFormFieldCallback? onSubmitted,
  }) {
    return InputReactive<T>(
      label: label,
      formControl: formControl,
      formControlName: formControlName,
      onSubmitted: onSubmitted,
      placeholder: placeholder,
      prefixIconConstraints: const BoxConstraints.tightFor(width: 30),
      prefixIcon: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          FlutterBaseIcon(
            icon: MoggieIcons.search_line,
            color: MoggieColors.specificContentHigh,
          ),
        ],
      ),
    );
  }
}

class ReactivePasswordInput extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final String? helperText;
  final FormControl formControl;
  final bool withFloatingLabel;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final ReactiveFormFieldCallback? onSubmitted;

  const ReactivePasswordInput({
    super.key,
    this.label,
    this.placeholder,
    this.helperText,
    this.withFloatingLabel = false,
    required this.formControl,
    this.validationMessages,
    this.onSubmitted,
  });

  @override
  State<ReactivePasswordInput> createState() => _ReactivePasswordInputState();
}

class _ReactivePasswordInputState extends State<ReactivePasswordInput> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return InputReactive(
      label: widget.label,
      placeholder: widget.placeholder,
      withFloatingLabel: widget.withFloatingLabel,
      obscureText: !showPassword,
      formControl: widget.formControl,
      onSubmitted: widget.onSubmitted,
      validationMessages: widget.validationMessages,
      suffixIcon: Transform.translate(
        offset: const Offset(10, 0),
        child: IconButton(
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          icon: const SvgFlutterBaseIcon(
            color: MoggieColors.specificContentLow,
            iconName: "eye_line",
          ),
        ),
      ),
    );
  }
}
