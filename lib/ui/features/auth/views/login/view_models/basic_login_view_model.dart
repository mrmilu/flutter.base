import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'basic_login_view_model.gform.dart';

@ReactiveFormAnnotation(name: 'BasicLoginModel')
class BasicLoginViewModel {
  final String email;
  final String password;

  BasicLoginModelForm get generateFormModel =>
      BasicLoginModelForm(BasicLoginModelForm.formElements(this), null);

  BasicLoginViewModel({
    @FormControlAnnotation(validators: [RequiredValidator()]) this.email = '',
    @FormControlAnnotation(validators: [RequiredValidator()])
    this.password = '',
  });
}
