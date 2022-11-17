import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/components/form/input_reactive.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/pages/auth/views/sign_up/sign_up_provider.dart';
import 'package:flutter_base/ui/pages/auth/views/sign_up/view_models/sign_up_view_model.dart';
import 'package:flutter_base/ui/utils/form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class SignUpForm extends ConsumerWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SignUpModelFormBuilder(
      model: SignUpViewModel(),
      builder: (context, formModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputReactive(
              formControl: formModel.nameControl,
              placeholder: LocaleKeys.signUp_form_name_label.tr(),
              textCapitalization: TextCapitalization.words,
              onSubmitted: (control) => formModel.form.focus("email"),
            ),
            BoxSpacer.v16(),
            InputReactive(
              formControl: formModel.emailControl,
              placeholder: LocaleKeys.signUp_form_email_label.tr(),
              keyboardType: TextInputType.emailAddress,
              onSubmitted: (control) => formModel.form.focus("password"),
            ),
            BoxSpacer.v16(),
            ReactivePasswordInput(
              formControl: formModel.passwordControl,
              placeholder: LocaleKeys.signUp_form_password_label.tr(),
              validationMessages: {
                ValidationMessage.pattern: (_) =>
                    LocaleKeys.formErrors_password.tr()
              },
            ),
            BoxSpacer.v24(),
            StreamBuilder<Map<String, Object?>?>(
              stream: formModel.form.valueChanges,
              builder: (context, snapshot) {
                var submitDisabled = true;
                if (snapshot.data != null) {
                  submitDisabled =
                      formValueIsEmpty(snapshot.data, "password") &&
                          formValueIsEmpty(snapshot.data, "email") &&
                          formValueIsEmpty(snapshot.data, "name");
                }

                return ButtonPrimary(
                  text: LocaleKeys.signUp_form_submit.tr(),
                  onPressed: submitDisabled
                      ? null
                      : () {
                          ref.read(signUpProvider).signUp(formModel);
                        },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
