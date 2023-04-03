// ignore_for_file: avoid-dynamic

import 'package:reactive_forms/reactive_forms.dart';

Map<String, dynamic>? requiredValidator(AbstractControl<dynamic> control) {
  return Validators.required(control);
}

Map<String, dynamic>? emailValidator(AbstractControl<dynamic> control) {
  return Validators.email(control);
}

Map<String, dynamic>? passwordValidator(AbstractControl<dynamic> control) {
  return Validators.pattern(
    RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$'),
  )(control);
}

Map<String, dynamic>? mustMatchPassword(AbstractControl<dynamic> control) {
  return Validators.mustMatch('password', 'repeatPassword', markAsDirty: false)(
    control,
  );
}

class ValidationMessages {
  static const String validateIf = 'validateIf';
  static const String atLeastOne = 'atLeastOne';
}
