// ignore_for_file: avoid-dynamic
import 'package:flutter_base/ui/validators/validators.dart';
import 'package:reactive_forms/reactive_forms.dart';

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

    final Map<String, dynamic>? validationOne = validation(controlOne);
    final Map<String, dynamic>? validationTwo = validation(controlTwo);

    if ((validationOne != null && validationOne.isNotEmpty) &&
        (validationTwo != null && validationTwo.isNotEmpty)) {
      return error;
    }

    return null;
  }
}
