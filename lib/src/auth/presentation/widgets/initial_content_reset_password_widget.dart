import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../settings/presentation/profile_info/access_data/change_password/info_password_validator_widget.dart';
import '../../../shared/data/services/app_flyer_service.dart';
import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../providers/reset_password/reset_password_cubit.dart';

class InitialContentResetPasswordWidget extends StatefulWidget {
  const InitialContentResetPasswordWidget({
    super.key,
    required this.currentStep,
  });
  final ValueNotifier<int> currentStep;

  @override
  State<InitialContentResetPasswordWidget> createState() =>
      _InitialContentResetPasswordWidgetState();
}

class _InitialContentResetPasswordWidgetState
    extends State<InitialContentResetPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  RMText.titleSmall(
                    context.cl.translate('pages.auth.resetPassword.title'),
                  ),
                  const SizedBox(height: 24),
                  CustomTextFieldWidget(
                    autoHideKeyboard: false,
                    enabled: !state.resultOr.isLoading,
                    obscureText: true,
                    autofocus: true,
                    labelText: context.cl.translate(
                      'pages.auth.resetPassword.form.newPassword',
                    ),
                    onChanged: context
                        .read<ResetPasswordCubit>()
                        .changePassword,
                  ),
                  const SizedBox(height: 4),
                  InfoPasswordValidatorWidget(
                    password: state.password,
                    showError: state.showErrors,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFieldWidget(
                    enabled: !state.resultOr.isLoading,
                    obscureText: true,
                    labelText: context.cl.translate(
                      'pages.auth.resetPassword.form.confirmPassword',
                    ),
                    showError: state.showErrors,
                    onChanged: context
                        .read<ResetPasswordCubit>()
                        .changeRepeatPassword,
                    errorText: state.repeatPassword != state.password
                        ? S.of(context).mismatchedPasswords
                        : null,
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  CustomElevatedButton.inverse(
                    isDisabled:
                        state.password.isEmpty ||
                        state.repeatPassword.isEmpty ||
                        keyGlobalDynamicLink == null,
                    onPressed: () => context
                        .read<ResetPasswordCubit>()
                        .resetPassword(keyGlobalDynamicLink!),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    label: context.cl.translate(
                      'pages.auth.resetPassword.form.button',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.paddingBottomPlus),
          ],
        );
      },
    );
  }
}
