import 'package:flutter_base/ui/validators/validators.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'sign_up_view_model.gform.dart';

@Rf(name: 'SignUpModel')
@FormGroupAnnotation()
class SignUpViewModel {
  final String email;
  final String name;
  final String password;

  SignUpModelForm get generateFormModel =>
      SignUpModelForm(SignUpModelForm.formElements(this), null);

  SignUpViewModel({
    @RfControl(validators: [RequiredValidator(), EmailValidator()])
    this.email = '',
    @RfControl(validators: [RequiredValidator()]) this.name = '',
    @RfControl(validators: [RequiredValidator(), PasswordValidator()])
    this.password = '',
  });
}
