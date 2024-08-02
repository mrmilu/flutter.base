// ignore_for_file: avoid-dynamic

import 'package:reactive_forms/reactive_forms.dart';

class PasswordValidator extends Validator<dynamic> {
  const PasswordValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl control) {
    return Validators.pattern(
      RegExp(r'^(?=.{8,}$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).*'),
    )(control);
  }
}

class MustMatchPassword extends Validator<dynamic> {
  const MustMatchPassword() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl control) {
    return Validators.mustMatch(
      'password',
      'repeatPassword',
      markAsDirty: false,
    )(control);
  }
}

class ValidationMessages {
  static const String validateIf = 'validateIf';
  static const String atLeastOne = 'atLeastOne';
}
