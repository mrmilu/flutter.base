import 'package:flutter_base/ui/utils/validators.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'meet_the_cat_view_model.gform.dart';

@ReactiveFormAnnotation(name: 'MeetTheCatModel')
@FormGroupAnnotation()
class MeetTheCatViewModel {
  final String name;
  final String? gender;

  MeetTheCatViewModel({
    @FormControlAnnotation(validators: [requiredValidator]) this.name = '',
    @FormControlAnnotation(validators: [requiredValidator]) this.gender,
  });
}
