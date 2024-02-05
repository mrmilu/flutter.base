import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'forgot_password_view_model.gform.dart';

@Rf(name: 'ForgotPasswordModel')
class ForgotPasswordViewModel {
  final String email;

  ForgotPasswordViewModel({
    @RfControl(validators: [RequiredValidator(), EmailValidator()])
    this.email = '',
  });

  ForgotPasswordModelForm get formModel =>
      ForgotPasswordModelForm(ForgotPasswordModelForm.formElements(this), null);
}
