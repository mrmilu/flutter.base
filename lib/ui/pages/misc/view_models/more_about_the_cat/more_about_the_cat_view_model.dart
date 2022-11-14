import 'package:flutter_base/ui/utils/validators.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'more_about_the_cat_view_model.gform.dart';

Map<String, dynamic>? birthdateValidator(AbstractControl<dynamic> control) {
  return ValidateControlIf<bool>(
          controlNameToCheck: 'knowsBirthdate',
          valueToCheck: true,
          controlNameToValidate: 'birthdate',
          validation: Validators.required)
      .validate(control);
}

Map<String, dynamic>? weightValidator(AbstractControl<dynamic> control) {
  return AtLeastOneValid(controlOneName: 'weight', controlTwoName: 'weightRange', validation: Validators.required)
      .validate(control);
}

Map<String, dynamic>? ageValidator(AbstractControl<dynamic> control) {
  return AtLeastOneValid(controlOneName: 'age', controlTwoName: 'birthdate', validation: Validators.required)
      .validate(control);
}

@ReactiveFormAnnotation(name: "MoreAboutTheCatModel")
@FormGroupAnnotation(validators: [birthdateValidator, ageValidator, weightValidator])
class MoreAboutTheCatViewModel {
  final String age;
  final bool? knowsBirthdate;
  final DateTime? birthdate;
  final String? weight;
  final int? weightRange;

  MoreAboutTheCatViewModel({
    @FormControlAnnotation() this.age = '',
    @FormControlAnnotation(validators: [requiredValidator]) this.knowsBirthdate,
    @FormControlAnnotation() this.birthdate,
    @FormControlAnnotation() this.weight,
    @FormControlAnnotation() this.weightRange,
  });
}
