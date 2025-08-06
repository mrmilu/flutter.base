import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/domain/failures_extensions/email_failure.extension.dart';
import '../../../shared/presentation/utils/assets/app_assets_icons.dart';
import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../pages/initial_page.dart';
import '../providers/forgot_password/forgot_password_cubit.dart';

class InitialContentForgotPasswordWidget extends StatelessWidget {
  const InitialContentForgotPasswordWidget({
    super.key,
    required this.currentStep,
  });
  final ValueNotifier<int> currentStep;

  void onTapSignIn() {
    currentStep.value = InitialStep.signInEmailPassword.index;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            RMText.titleMedium(
              context.cl.translate('pages.auth.forgotPassword.title'),
            ),
            const SizedBox(height: 24),
            RMText.bodyMedium(
              context.cl.translate('pages.auth.forgotPassword.subtitle'),
              height: 1.5,
            ),
            const SizedBox(height: 32),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
                return CustomTextFieldWidget(
                  labelText: context.cl.translate(
                    'pages.auth.forgotPassword.form.email',
                  ),
                  autoHideKeyboard: false,
                  onChanged: context.read<ForgotPasswordCubit>().changeEmail,
                  keyboardType: TextInputType.emailAddress,
                  showError: state.showErrors,
                  errorText: state.emailVos.map(
                    isLeft: (e) => e.toTranslation(context),
                    isRight: (_) => null,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                state.resultOr.whenIsSuccess(
                  () {
                    currentStep.value = InitialStep.checkEmailToPassword.index;
                  },
                );
              },
              builder: (context, state) {
                return CustomElevatedButton.inverse(
                  isDisabled: state.email.isEmpty,
                  onPressed: () =>
                      context.read<ForgotPasswordCubit>().forgotPassword(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  label: context.cl.translate(
                    'pages.auth.forgotPassword.form.button',
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomTextButton.icon(
                onPressed: onTapSignIn,
                label: context.cl.translate(
                  'pages.auth.forgotPassword.backToLogin',
                ),
                iconPath: AppAssetsIcons.arrowRight,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
