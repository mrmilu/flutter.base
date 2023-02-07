import 'package:flutter_base/ui/utils/validators.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'basic_login_view_model.gform.dart';

@ReactiveFormAnnotation(name: 'BasicLoginModel')
class BasicLoginViewModel {
  final String email;
  final String password;

  BasicLoginViewModel({
    @FormControlAnnotation(validators: [requiredValidator]) this.email = '',
    @FormControlAnnotation(validators: [requiredValidator]) this.password = '',
  });
}
