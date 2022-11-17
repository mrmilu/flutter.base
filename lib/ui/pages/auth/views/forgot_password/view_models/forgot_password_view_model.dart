import 'package:flutter_base/ui/utils/validators.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'forgot_password_view_model.gform.dart';

@ReactiveFormAnnotation(name: 'ForgotPasswordModel')
class ForgotPasswordViewModel {
  final String email;

  ForgotPasswordViewModel({
    @FormControlAnnotation(validators: [requiredValidator, emailValidator])
        this.email = '',
  });
}
