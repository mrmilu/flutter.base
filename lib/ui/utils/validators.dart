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

class ValidateControlIf<T> extends Validator<dynamic> {
  final String controlNameToCheck;
  final T valueToCheck;
  final String controlNameToValidate;
  final Map<String, dynamic>? Function(AbstractControl<dynamic> control)
      validation;

  ValidateControlIf({
    required this.controlNameToCheck,
    required this.controlNameToValidate,
    required this.valueToCheck,
    required this.validation,
  });

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = {ValidationMessages.validateIf: true};

    if (control is! FormGroup) {
      return error;
    }

    final controlToCheck = control.control(controlNameToCheck);
    final controlToValidate = control.control(controlNameToValidate);

    Map<String, dynamic>? validationError = validation(controlToValidate);

    final controlMustBeValue = controlToCheck.value == valueToCheck;
    if (controlMustBeValue &&
        validationError != null &&
        validationError.isNotEmpty) {
      controlToValidate.setErrors(error, markAsDirty: false);
      controlToValidate.markAsTouched();
    } else {
      controlToValidate.removeError(ValidationMessages.validateIf);
    }

    return null;
  }
}

class AtLeastOneValid<T> extends Validator<dynamic> {
  final String controlOneName;
  final String controlTwoName;
  final Map<String, dynamic>? Function(AbstractControl<dynamic> control)
      validation;

  AtLeastOneValid({
    required this.controlOneName,
    required this.controlTwoName,
    required this.validation,
  });

  @override
  Map<String, dynamic>? validate(AbstractControl control) {
    final error = {ValidationMessages.atLeastOne: true};

    if (control is! FormGroup) {
      return error;
    }

    final controlOne = control.control(controlOneName);
    final controlTwo = control.control(controlTwoName);

    Map<String, dynamic>? validationOne = validation(controlOne);
    Map<String, dynamic>? validationTwo = validation(controlTwo);

    if ((validationOne != null && validationOne.isNotEmpty) &&
        (validationTwo != null && validationTwo.isNotEmpty)) {
      return error;
    }

    return null;
  }
}
