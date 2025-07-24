import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/domain/failures_extensions/email_failure.extension.dart';
import '../../../shared/helpers/extensions.dart';
import '../../../shared/presentation/utils/open_web_view_utils.dart';
import '../../../shared/presentation/utils/styles/colors.dart';
import '../../../shared/presentation/utils/styles/text_styles.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_outlined_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/text/text_body.dart';
import '../../../shared/presentation/widgets/text/text_title.dart';
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
            TextTitle.two(
              context.cl.translate('pages.auth.signUp.contentEmail.title'),
            ),
            const SizedBox(height: 24),
            TextBody.two(
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
                    isLeft: (e) => e.toTranslation(context),
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
                TextBody.two(
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
                      iconPath: 'assets/icons/logo_apple.svg',
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
                    iconPath: 'assets/icons/logo_google.svg',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomTextButton.icon(
                onPressed: onTapLogin,
                label: context.cl.translate(
                  'pages.auth.signUp.contentEmail.amClient',
                ),
                iconPath: 'assets/icons/arrow_right.svg',
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
                style: TextStyles.caption3.copyWith(
                  color: AppColors.specificBasicBlack,
                ),
                children: [
                  TextSpan(
                    text: context.cl.translate(
                      'pages.auth.signUp.contentEmail.terms',
                    ),
                    style: TextStyles.caption3.copyWith(
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
                    style: TextStyles.caption3.copyWith(
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
