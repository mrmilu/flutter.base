import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/components/form/password_reactive_input.dart';
import 'package:flutter_base/ui/components/form/reactive_input.dart';
import 'package:flutter_base/ui/features/auth/views/sign_up/sign_up_provider.dart';
import 'package:flutter_base/ui/features/auth/views/sign_up/view_models/sign_up_view_model.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class SignUpForm extends ConsumerWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final formModel = ref.watch(signUpProvider);
    return ReactiveSignUpModelForm(
      form: formModel,
      child: ReactiveFormBuilder(
        form: () => formModel.form,
        builder: (context, formGroup, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReactiveInput(
                formControl: formModel.nameControl,
                placeholder: LocaleKeys.signUp_form_name_label.tr(),
                textCapitalization: TextCapitalization.words,
                onSubmitted: (control) => formModel.form.focus('email'),
              ),
              BoxSpacer.v16(),
              ReactiveInput(
                formControl: formModel.emailControl,
                placeholder: LocaleKeys.signUp_form_email_label.tr(),
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (control) => formModel.form.focus('password'),
              ),
              BoxSpacer.v16(),
              PasswordReactiveInput(
                formControl: formModel.passwordControl,
                placeholder: LocaleKeys.signUp_form_password_label.tr(),
                validationMessages: {
                  ValidationMessage.pattern: (_) =>
                      LocaleKeys.errors_form_password.tr()
                },
              ),
              BoxSpacer.v24(),
              ReactiveSignUpModelFormConsumer(
                builder: (context, consumerModel, _) {
                  return ButtonPrimary(
                    text: LocaleKeys.signUp_form_submit.tr(),
                    onPressed: !consumerModel.form.valid
                        ? null
                        : () {
                            ref.read(signUpProvider.notifier).signUp();
                          },
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
