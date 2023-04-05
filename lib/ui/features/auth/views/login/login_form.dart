import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/components/buttons/button_tertiary.dart';
import 'package:flutter_base/ui/components/form/email_reactive_input.dart';
import 'package:flutter_base/ui/components/form/password_reactive_input.dart';
import 'package:flutter_base/ui/features/auth/views/login/login_provider.dart';
import 'package:flutter_base/ui/features/auth/views/login/view_models/basic_login_view_model.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/view_models/button_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formModel = ref.watch(loginProvider);
    return ReactiveBasicLoginModelForm(
      form: formModel,
      child: ReactiveFormBuilder(
        form: () => formModel.form,
        builder: (context, formGroup, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EmailReactiveInput(
                key: const Key('sing_in_email'),
                formControl: formModel.emailControl,
                placeholder: LocaleKeys.login_form_email_label.tr(),
                onSubmitted: (control) => formModel.form.focus('password'),
              ),
              BoxSpacer.v16(),
              PasswordReactiveInput(
                key: const Key('sing_in_pass'),
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
                    GoRouter.of(context).push('/forgot-password');
                  },
                ),
              ),
              BoxSpacer.v16(),
              ReactiveBasicLoginModelFormConsumer(
                builder: (context, consumerModel, _) {
                  return ButtonPrimary(
                    key: const Key('sing_in_button'),
                    text: LocaleKeys.login_form_submit.tr(),
                    onPressed: consumerModel.form.valid
                        ? () => ref.read(loginProvider.notifier).login()
                        : null,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
