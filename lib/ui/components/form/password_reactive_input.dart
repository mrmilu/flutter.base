import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/form/reactive_input.dart';
import 'package:flutter_base/ui/components/icons/flutter_base_svg_icon.dart';

import 'package:reactive_forms/reactive_forms.dart';

class PasswordReactiveInput extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final String? helperText;
  final FormControl formControl;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final ReactiveFormFieldCallback? onSubmitted;

  const PasswordReactiveInput({
    super.key,
    this.label,
    this.placeholder,
    this.helperText,
    required this.formControl,
    this.validationMessages,
    this.onSubmitted,
  });

  @override
  State<PasswordReactiveInput> createState() => _PasswordReactiveInputState();
}

class _PasswordReactiveInputState extends State<PasswordReactiveInput> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return ReactiveInput(
      label: widget.label,
      placeholder: widget.placeholder,
      obscureText: !showPassword,
      formControl: widget.formControl,
      onSubmitted: widget.onSubmitted,
      validationMessages: widget.validationMessages,
      autofillHints: const [AutofillHints.password],
      suffixIcon: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        icon: const FlutterBaseSvgIcon(
          iconName: 'eye_line',
        ),
      ),
    );
  }
}
