import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../settings/presentation/profile_info/access_data/change_password/info_password_validator_widget.dart';
import '../../../shared/domain/failures_extensions/email_failure.extension.dart';
import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../../shared/presentation/utils/assets/app_assets_icons.dart';
import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/widgets/common/image_asset_widget.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../pages/initial_page.dart';
import '../signup/providers/signup_cubit.dart';

class InitialContentSignUpEmailPasswordWidget extends StatelessWidget {
  const InitialContentSignUpEmailPasswordWidget({
    super.key,
    required this.currentStep,
  });
  final ValueNotifier<int> currentStep;

  void onTapBack(BuildContext context) {
    currentStep.value = InitialStep.signUpEmail.index;
    context.read<SignupCubit>().reset();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => onTapBack(context),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ImageAssetWidget(
                          path: AppAssetsIcons.arrowIosLeft,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RMText.titleSmall(
                        context.cl.translate(
                          'pages.auth.signUp.contentPassword.title',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                RMText.bodyMedium(
                  context.cl.translate(
                    'pages.auth.signUp.contentPassword.subtitle',
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextFieldWidget(
                  initialValue: state.email,
                  onChanged: context.read<SignupCubit>().changeEmail,
                  keyboardType: TextInputType.emailAddress,
                  labelText: context.cl.translate(
                    'pages.auth.signUp.contentEmail.form.email',
                  ),
                  showError: state.showErrors,
                  errorText: state.emailVos.map(
                    isLeft: (e) => e.toTranslate(context),
                    isRight: (_) => null,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextFieldWidget(
                  autoHideKeyboard: false,
                  enabled: !state.resultOr.isLoading,
                  obscureText: true,
                  autofocus: true,
                  labelText: context.cl.translate(
                    'pages.profileInfoAccessDataPassword.form.password',
                  ),
                  onChanged: context.read<SignupCubit>().changePassword,
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
                    'pages.profileInfoAccessDataPassword.form.repeatPassword',
                  ),
                  showError: state.showErrors,
                  onChanged: context.read<SignupCubit>().changeRepeatPassword,
                  errorText: state.repeatPassword != state.password
                      ? S.of(context).mismatchedPasswords
                      : null,
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                CustomElevatedButton.inverse(
                  isDisabled:
                      state.password.isEmpty || state.repeatPassword.isEmpty,
                  onPressed: () => context.read<SignupCubit>().signUp(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  label: context.cl.translate(
                    'pages.auth.signUp.contentPassword.form.button',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
