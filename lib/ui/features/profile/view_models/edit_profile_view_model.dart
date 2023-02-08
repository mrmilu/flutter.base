import 'package:flutter_base/ui/utils/reactive_form.dart';
import 'package:flutter_base/ui/utils/validators.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'edit_profile_view_model.gform.dart';

@ReactiveFormAnnotation(name: 'EditProfileModel')
class EditProfileViewModel {
  final String name;

  EditProfileViewModel({
    @FormControlAnnotation(validators: [requiredValidator]) this.name = '',
  });

  EditProfileModelForm generateFormModel() =>
      buildFormModel((form) => EditProfileModelForm(this, form, null));
}
