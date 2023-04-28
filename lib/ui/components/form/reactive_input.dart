import 'package:flutter/material.dart';
import 'package:flutter_base/ui/extensions/media_query.dart';
import 'package:flutter_base/ui/styles/insets.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveInput<T> extends ReactiveTextField {
  ReactiveInput({
    String? label,
    String? placeholder,
    String? helperText,
    bool withFloatingLabel = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    BoxConstraints? suffixIconConstraints,
    BoxConstraints? prefixIconConstraints,
    ShowErrorsFunction? showErrors,
    super.autofillHints,
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
          'At least a placeholder or label should be given',
        ),
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
          scrollPadding:
              GetIt.I.get<GlobalKey<ScaffoldMessengerState>>().currentContext !=
                      null
                  ? MediaQuery.of(
                      // ignore: avoid-non-null-assertion
                      GetIt.I
                          .get<GlobalKey<ScaffoldMessengerState>>()
                          .currentContext!,
                    ).textFieldScrollPadding
                  : Insets.a20,
        );
}
