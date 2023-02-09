import 'package:flutter_base/ui/utils/reactive_form.dart';
import 'package:flutter_base/ui/utils/validators.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'sign_up_view_model.gform.dart';

@ReactiveFormAnnotation(name: 'SignUpModel')
@FormGroupAnnotation()
class SignUpViewModel {
  final String email;
  final String name;
  final String password;

  SignUpViewModel({
    @FormControlAnnotation(validators: [requiredValidator, emailValidator])
        this.email = '',
    @FormControlAnnotation(validators: [requiredValidator]) this.name = '',
    @FormControlAnnotation(validators: [requiredValidator, passwordValidator])
        this.password = '',
  });

  SignUpModelForm generateFormModel() =>
      buildFormModel((form) => SignUpModelForm(this, form, null));
}
