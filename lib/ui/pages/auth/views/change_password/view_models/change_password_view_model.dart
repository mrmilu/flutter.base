import 'package:flutter_base/ui/utils/validators.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'change_password_view_model.gform.dart';

Map<String, dynamic>? mustMatchPassword(AbstractControl<dynamic> control) {
  return Validators.mustMatch("password", "repeatPassword", markAsDirty: false)(
      control);
}

@ReactiveFormAnnotation(name: "ChangePasswordModel")
@FormGroupAnnotation(validators: [mustMatchPassword])
class ChangePasswordViewModel {
  final String password;
  final String repeatPassword;

  ChangePasswordViewModel({
    @FormControlAnnotation(validators: [requiredValidator, passwordValidator])
        this.password = "",
    @FormControlAnnotation(validators: [requiredValidator, passwordValidator])
        this.repeatPassword = "",
  });
}
