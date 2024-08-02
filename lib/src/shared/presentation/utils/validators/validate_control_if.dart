// ignore_for_file: avoid-dynamic
import 'package:flutter_base/src/shared/presentation/utils/validators/validators.dart';
import 'package:reactive_forms/reactive_forms.dart';

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

    final Map<String, dynamic>? validationError = validation(controlToValidate);

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
