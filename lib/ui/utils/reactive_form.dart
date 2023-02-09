import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

abstract class GeneratedFormModel {
  FormGroup formElements();
}

T buildFormModel<T>(T Function(FormGroup form) generator) {
  var form = FormGroup({});
  dynamic formModel = generator(form);

  final elements = formModel.formElements();
  form.setValidators(elements.validators);
  form.setAsyncValidators(elements.asyncValidators);

  if (elements.disabled) {
    form.markAsDisabled();
  }

  form.addAll(elements.controls);

  return formModel;
}
