import 'package:flutter_base/ui/validators/validators.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'change_password_view_model.gform.dart';

@Rf(name: 'ChangePasswordModel')
@FormGroupAnnotation(validators: [MustMatchPassword()])
class ChangePasswordViewModel {
  final String password;
  final String repeatPassword;

  ChangePasswordViewModel({
    @RfControl(
      validators: [RequiredValidator(), PasswordValidator()],
    )
    this.password = '',
    @RfControl(
      validators: [RequiredValidator(), PasswordValidator()],
    )
    this.repeatPassword = '',
  });

  ChangePasswordModelForm get formModel => ChangePasswordModelForm(
        ChangePasswordModelForm.formElements(this),
        null,
      );
}
