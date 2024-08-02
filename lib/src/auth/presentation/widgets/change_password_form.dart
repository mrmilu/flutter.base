import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/src/auth/application/change_password_provider.dart';
import 'package:flutter_base/src/auth/presentation/view_models/change_password_view_model.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/box_spacer.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/buttons/button_primary.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/form/password_reactive_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class ChangePasswordForm extends ConsumerStatefulWidget {
  final String token;
  final String uid;

  const ChangePasswordForm({
    super.key,
    required this.token,
    required this.uid,
  });

  @override
  ConsumerState<ChangePasswordForm> createState() =>
      _BasicLoginFormWidgetState();
}

class _BasicLoginFormWidgetState extends ConsumerState<ChangePasswordForm> {
  bool showPassword = false;
  bool showRepeatPassword = false;

  @override
  Widget build(BuildContext context) {
    final formModel = ref.watch(changePasswordProvider);
    return ReactiveChangePasswordModelForm(
      form: formModel,
      child: ReactiveFormBuilder(
        form: () => formModel.form,
        builder: (context, _, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PasswordReactiveInput(
                key: const Key('change-password-pass1'),
                formControl: formModel.passwordControl,
                placeholder: LocaleKeys.changePassword_form_password_label.tr(),
                onSubmitted: (control) =>
                    formModel.form.focus('repeatPassword'),
              ),
              BoxSpacer.v16(),
              PasswordReactiveInput(
                key: const Key('change-password-pass2'),
                formControl: formModel.repeatPasswordControl,
                placeholder:
                    LocaleKeys.changePassword_form_repeatPassword_label.tr(),
                validationMessages: {
                  ValidationMessage.mustMatch: (_) =>
                      LocaleKeys.errors_form_passwordMatch.tr(),
                },
              ),
              BoxSpacer.v24(),
              ReactiveChangePasswordModelFormConsumer(
                builder: (context, consumerModel, _) {
                  return ButtonPrimary(
                    key: const Key('change-password-button'),
                    text: LocaleKeys.changePassword_form_submit.tr(),
                    onPressed: consumerModel.form.valid
                        ? () {
                            ref
                                .read(changePasswordProvider.notifier)
                                .changePassword(
                                  token: widget.token,
                                  uid: widget.uid,
                                );
                          }
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
