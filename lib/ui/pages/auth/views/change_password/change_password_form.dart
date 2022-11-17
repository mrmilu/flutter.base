import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/components/form/input_reactive.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/pages/auth/views/change_password/change_password_provider.dart';
import 'package:flutter_base/ui/pages/auth/views/change_password/view_models/change_password_view_model.dart';
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
    return ChangePasswordModelFormBuilder(
      model: ChangePasswordViewModel(),
      builder: (context, formModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReactivePasswordInput(
              formControl: formModel.passwordControl,
              placeholder: LocaleKeys.changePassword_form_password_label.tr(),
              onSubmitted: (control) => formModel.form.focus('repeatPassword'),
            ),
            BoxSpacer.v16(),
            ReactivePasswordInput(
              formControl: formModel.repeatPasswordControl,
              placeholder:
                  LocaleKeys.changePassword_form_repeatPassword_label.tr(),
              validationMessages: {
                ValidationMessage.mustMatch: (_) =>
                    LocaleKeys.formErrors_passwordMatch.tr()
              },
            ),
            BoxSpacer.v24(),
            ReactiveChangePasswordModelFormConsumer(
              builder: (context, consumerModel, _) {
                return ButtonPrimary(
                  text: LocaleKeys.changePassword_form_submit.tr(),
                  onPressed: consumerModel.form.valid
                      ? () {
                          ref.read(changePasswordProvider).changePassword(
                                formModel,
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
    );
  }
}
