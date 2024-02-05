import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'edit_profile_view_model.gform.dart';

@Rf(name: 'EditProfileModel')
class EditProfileViewModel {
  final String name;

  EditProfileModelForm get generateFormModel =>
      EditProfileModelForm(EditProfileModelForm.formElements(this), null);

  EditProfileViewModel({
    @RfControl(validators: [RequiredValidator()]) this.name = '',
  });
}
