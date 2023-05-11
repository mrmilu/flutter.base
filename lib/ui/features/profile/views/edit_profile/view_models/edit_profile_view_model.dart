import 'package:flutter_base/ui/validators/validators.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'edit_profile_view_model.gform.dart';

@ReactiveFormAnnotation(name: 'EditProfileModel')
class EditProfileViewModel {
  final String name;

  EditProfileModelForm get generateFormModel =>
      EditProfileModelForm(this, EditProfileModelForm.formElements(this), null);

  EditProfileViewModel({
    @FormControlAnnotation(validators: [requiredValidator]) this.name = '',
  });
}
