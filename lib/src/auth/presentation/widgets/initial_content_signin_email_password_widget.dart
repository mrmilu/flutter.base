import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/domain/failures_extensions/email_failure.extension.dart';
import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/widgets/common/image_asset_widget.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../pages/initial_page.dart';
import '../signin/providers/signin_cubit.dart';

class InitialContentSignInEmailPasswordWidget extends StatelessWidget {
  const InitialContentSignInEmailPasswordWidget({
    super.key,
    required this.currentStep,
  });
  final ValueNotifier<int> currentStep;

  void onTapBack(BuildContext context) {
    currentStep.value = InitialStep.signInEmail.index;
    context.read<SigninCubit>().reset();
  }

  void onTapForgotPassword() {
    currentStep.value = InitialStep.forgetPassword.index;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<SigninCubit, SigninState>(
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
                        path: 'assets/icons/arrow_ios_left.svg',
                      ),
                    ),
                  ),
                  Expanded(
                    child: RMText.titleSmall(
                      context.cl.translate(
                        'pages.auth.signIn.contentPassword.title',
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
                  'pages.auth.signIn.contentPassword.subtitle',
                ),
              ),
              const SizedBox(height: 24),
              CustomTextFieldWidget(
                initialValue: state.email,
                onChanged: context.read<SigninCubit>().changeEmail,
                keyboardType: TextInputType.emailAddress,
                labelText: context.cl.translate(
                  'pages.auth.signUp.contentEmail.form.email',
                ),
                showError: state.showErrors,
                errorText: state.emailVos.map(
                  isLeft: (e) => e.toTranslation(context),
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
                  'pages.auth.signIn.contentPassword.form.password',
                ),
                onChanged: context.read<SigninCubit>().changePassword,
                // showError: state.showErrors,
                // errorText: state.passwordVos.map(
                //   isLeft: (e) => e.toTranslation(context),
                //   isRight: (_) => null,
                // ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomTextButton.icon(
                  onPressed: onTapForgotPassword,
                  label: context.cl.translate(
                    'pages.auth.signIn.contentPassword.forgotPassword',
                  ),
                  iconPath: 'assets/icons/arrow_right.svg',
                ),
              ),
              const Divider(),
              const SizedBox(height: 8),
              CustomElevatedButton.inverse(
                isDisabled: state.password.isEmpty,
                onPressed: () => context.read<SigninCubit>().signin(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                label: context.cl.translate(
                  'pages.auth.signIn.contentPassword.form.button',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
