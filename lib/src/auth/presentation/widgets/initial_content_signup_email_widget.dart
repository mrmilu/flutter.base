import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/extensions/failures/email_failure.extension.dart';
import '../../../shared/presentation/utils/assets/app_assets_icons.dart';
import '../../../shared/presentation/utils/open_web_view_utils.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_outlined_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../pages/initial_page.dart';
import '../providers/signin_social/signin_social_cubit.dart';
import '../signup/providers/signup_cubit.dart';

class InitialContentSignUpEmailWidget extends StatelessWidget {
  const InitialContentSignUpEmailWidget({super.key, required this.currentStep});
  final ValueNotifier<int> currentStep;

  void onTapContinue(BuildContext context) {
    context.read<SignupCubit>().validateEmail();
    final emailVos = context.read<SignupCubit>().state.emailVos;
    if (emailVos.isValid()) {
      currentStep.value = InitialStep.signUpEmailPassword.index;
    }
  }

  void onTapLogin() {
    currentStep.value = InitialStep.signInEmail.index;
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
              context.cl.translate('pages.auth.signUp.contentEmail.title'),
            ),
            const SizedBox(height: 24),
            RMText.bodyMedium(
              context.cl.translate('pages.auth.signUp.contentEmail.subtitle'),
            ),
            const SizedBox(height: 32),
            BlocBuilder<SignupCubit, SignupState>(
              builder: (context, state) {
                return CustomTextFieldWidget(
                  labelText: context.cl.translate(
                    'pages.auth.signUp.contentEmail.form.email',
                  ),
                  autoHideKeyboard: false,
                  onChanged: context.read<SignupCubit>().changeEmail,
                  keyboardType: TextInputType.emailAddress,
                  showError: state.showErrors,
                  errorText: state.emailVos.map(
                    isLeft: (e) => e.toTranslate(context),
                    isRight: (_) => null,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            BlocBuilder<SignupCubit, SignupState>(
              builder: (context, state) {
                return CustomElevatedButton.inverse(
                  isDisabled: state.email.isEmpty,
                  onPressed: () => onTapContinue(context),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  label: context.cl.translate(
                    'pages.auth.signUp.contentEmail.form.button',
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(child: Divider()),
                const SizedBox(width: 8),
                RMText.bodyMedium(
                  context.cl.translate('pages.auth.signUp.contentEmail.or'),
                ),
                const SizedBox(width: 8),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (Platform.isIOS) ...[
                  Expanded(
                    child: CustomOutlinedButton.primary(
                      onPressed: () =>
                          context.read<SigninSocialCubit>().signInWithApple(),
                      label: context.cl.translate(
                        'pages.auth.signUp.contentEmail.socials.apple',
                      ),
                      iconPath: AppAssetsIcons.logoApple,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: CustomOutlinedButton.primary(
                    onPressed: () =>
                        context.read<SigninSocialCubit>().signInWithGoogle(),
                    label: context.cl.translate(
                      'pages.auth.signUp.contentEmail.socials.google',
                    ),
                    iconPath: AppAssetsIcons.logoGoogle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomTextButton.iconSecondary(
                onPressed: onTapLogin,
                label: context.cl.translate(
                  'pages.auth.signUp.contentEmail.amClient',
                ),
                iconPath: AppAssetsIcons.arrowRight,
              ),
            ),
            const SizedBox(height: 40),
            RichText(
              text: TextSpan(
                text:
                    context.cl.translate(
                      'pages.auth.signUp.contentEmail.review',
                    ) +
                    ' ',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colors.specificBasicBlack,
                ),
                children: [
                  TextSpan(
                    text: context.cl.translate(
                      'pages.auth.signUp.contentEmail.terms',
                    ),
                    style: context.textTheme.labelSmall?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        openWebView(
                          context: context,
                          title: context.cl.translate(
                            'pages.auth.signUp.contentEmail.terms',
                          ),
                          url: context.cl.translate(
                            'urls.termsAndConditions',
                          ),
                        );
                      },
                  ),
                  TextSpan(
                    text:
                        ' ${context.cl.translate('pages.auth.signUp.contentEmail.and')} ',
                  ),
                  TextSpan(
                    text: context.cl.translate(
                      'pages.auth.signUp.contentEmail.privacy',
                    ),
                    style: context.textTheme.labelSmall?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        openWebView(
                          context: context,
                          title: context.cl.translate(
                            'pages.auth.signUp.contentEmail.privacy',
                          ),
                          url: context.cl.translate('urls.privacyPolicy'),
                        );
                      },
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
