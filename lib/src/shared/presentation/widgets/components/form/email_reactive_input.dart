import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/form/reactive_input.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EmailReactiveInput<T> extends StatelessWidget {
  final String? label;
  final FormControl<T>? formControl;
  final String? placeholder;
  final ReactiveFormFieldCallback? onSubmitted;

  const EmailReactiveInput({
    super.key,
    this.label,
    this.formControl,
    this.placeholder,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveInput<T>(
      label: label,
      formControl: formControl,
      keyboardType: TextInputType.emailAddress,
      onSubmitted: onSubmitted,
      placeholder: placeholder,
      autofillHints: const [AutofillHints.email],
    );
  }
}
