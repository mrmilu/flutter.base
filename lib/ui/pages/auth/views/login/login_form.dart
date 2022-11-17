import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/components/buttons/button_tertiary.dart';
import 'package:flutter_base/ui/components/form/input_reactive.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/pages/auth/views/login/login_provider.dart';
import 'package:flutter_base/ui/pages/auth/views/login/view_models/basic_login_view_model.dart';
import 'package:flutter_base/ui/utils/form.dart';
import 'package:flutter_base/ui/view_models/button_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  ConsumerState<LoginForm> createState() => _BasicLoginFormWidgetState();
}

class _BasicLoginFormWidgetState extends ConsumerState<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BasicLoginModelFormBuilder(
      model: BasicLoginViewModel(),
      builder: (context, formModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputReactive.email(
              formControl: formModel.emailControl,
              placeholder: LocaleKeys.login_form_email_label.tr(),
              onSubmitted: (control) => formModel.form.focus("password"),
            ),
            BoxSpacer.v16(),
            ReactivePasswordInput(
              placeholder: LocaleKeys.login_form_password_label.tr(),
              formControl: formModel.passwordControl,
            ),
            BoxSpacer.v16(),
            Align(
              alignment: Alignment.centerLeft,
              child: ButtonTertiary(
                text: LocaleKeys.login_forgotPassword.tr(),
                size: ButtonSize.small,
                onPressed: () {
                  GoRouter.of(context).push("/forgot-password");
                },
              ),
            ),
            BoxSpacer.v16(),
            StreamBuilder<Map<String, Object?>?>(
              stream: formModel.form.valueChanges,
              builder: (context, snapshot) {
                var submitDisabled = true;
                if (snapshot.data != null) {
                  submitDisabled =
                      formValueIsEmpty(snapshot.data, "password") &&
                          formValueIsEmpty(snapshot.data, "email");
                }

                return ButtonPrimary(
                  text: LocaleKeys.login_form_submit.tr(),
                  onPressed: submitDisabled
                      ? null
                      : () => ref.read(loginProvider).login(formModel),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
