import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../settings/presentation/profile_info/access_data/change_password/info_password_validator_widget.dart';
import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/extensions/failures/email_failure.extension.dart';
import '../../../shared/presentation/extensions/failures/fullname_failure_extension.dart';
import '../../../shared/presentation/helpers/toasts.dart';
import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/router/page_names.dart';
import '../../../shared/presentation/utils/assets/app_assets_icons.dart';
import '../../../shared/presentation/utils/open_web_view_utils.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_icon_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../../../shared/presentation/widgets/components/checkboxs/custom_checkbox_widget.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../domain/failures/oauth_sign_in_failure.dart';
import '../../domain/interfaces/i_auth_repository.dart';
import '../extensions/oauth_sign_in_failure_extension.dart';
import '../extensions/signup_failure_extension.dart';
import '../providers/auth/auth_cubit.dart';
import '../providers/signin_social/signin_social_cubit.dart';
import 'providers/signup_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupCubit(
            authRepository: context.read<IAuthRepository>(),
            authCubit: context.read<AuthCubit>(),
            globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => SigninSocialCubit(
            authRepository: context.read<IAuthRepository>(),
          ),
        ),
      ],
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late FocusNode _fullnameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _repeatPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _fullnameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _fullnameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repeatPasswordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context, SignupState state) {
    if (state.name.isNotEmpty &&
        state.email.isNotEmpty &&
        state.password.isNotEmpty &&
        state.repeatPassword.isNotEmpty &&
        state.password == state.repeatPassword &&
        state.agreeTerms) {
      context.read<SignupCubit>().signUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state.user != null) {
              if (!state.user!.isValidated) {
                routerApp.goNamed(PageNames.validateEmail);
                return;
              }
              routerApp.goNamed(PageNames.mainHome);
            }
          },
        ),
        BlocListener<SignupCubit, SignupState>(
          listenWhen: (previous, current) =>
              previous.resultOr != current.resultOr,
          listener: (context, state) {
            state.resultOr.whenIsFailure(
              (e) => showError(
                context,
                message: e.toTranslate(context),
                duration: 3,
              ),
            );
            state.resultOr.whenIsSuccess(
              () async {
                await context.read<AuthCubit>().loginUser();
              },
            );
          },
        ),
        BlocListener<SigninSocialCubit, SigninSocialState>(
          listener: (context, state) {
            state.resultOr.whenIsFailure(
              (e) {
                if (e is! OAuthSignInFailureCancel) {
                  showError(
                    context,
                    message: e.toTranslate(context),
                  );
                }
              },
            );
            state.resultOr.whenIsSuccess(
              () {
                context.read<AuthCubit>().loginUser();
              },
            );
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Form(
            child: BlocConsumer<SignupCubit, SignupState>(
              listener: (context, state) {
                state.resultOr.whenIsFailure(
                  (e) {
                    showError(
                      context,
                      message: e.toTranslate(context),
                    );
                  },
                );
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 24),
                        Center(
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: context.colors.iconBlack,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_add,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),
                        Center(
                          child: RMText.titleLarge(
                            context.cl.translate(
                              'pages.auth.signUp.title',
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Center(
                          child: RMText.bodyMedium(
                            context.cl.translate(
                              'pages.auth.signUp.subtitle',
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomTextFieldWidget(
                          initialValue: state.name,
                          onChanged: context.read<SignupCubit>().changeName,
                          keyboardType: TextInputType.name,

                          textInputAction: TextInputAction.next,
                          focusNode: _fullnameFocusNode,
                          onSubmitted: (_) => _emailFocusNode.requestFocus(),
                          labelText: context.cl.translate(
                            'pages.auth.signUp.form.name',
                          ),
                          showError: state.showErrors,
                          errorText: state.nameVos.map(
                            isLeft: (e) => e.toTranslate(context),
                            isRight: (_) => null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextFieldWidget(
                          initialValue: state.email,
                          onChanged: context.read<SignupCubit>().changeEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          focusNode: _emailFocusNode,
                          onSubmitted: (_) => _passwordFocusNode.requestFocus(),
                          labelText: context.cl.translate(
                            'pages.auth.signUp.form.email',
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
                          focusNode: _passwordFocusNode,
                          onSubmitted: (_) =>
                              _repeatPasswordFocusNode.requestFocus(),
                          labelText: context.cl.translate(
                            'pages.auth.signUp.form.password',
                          ),
                          textInputAction: TextInputAction.next,
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
                          focusNode: _repeatPasswordFocusNode,
                          onSubmitted: (_) => _submitForm(context, state),
                          labelText: context.cl.translate(
                            'pages.auth.signUp.form.repeatPassword',
                          ),
                          showError: state.showErrors,
                          textInputAction: TextInputAction.done,
                          onChanged: context
                              .read<SignupCubit>()
                              .changeRepeatPassword,
                          errorText: state.repeatPassword != state.password
                              ? S.of(context).mismatchedPasswords
                              : null,
                        ),
                        const SizedBox(height: 12),
                        CustomCheckboxWidget(
                          textCheckbox: '',
                          childContent: RichText(
                            text: TextSpan(
                              text:
                                  '${context.cl.translate(
                                    'pages.auth.signUp.agree',
                                  )} ',
                              style: context.textTheme.labelMedium?.copyWith(
                                color: context.colors.specificBasicBlack,
                              ),
                              children: [
                                TextSpan(
                                  text: context.cl.translate(
                                    'pages.auth.signUp.terms',
                                  ),
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      openWebView(
                                        context: context,
                                        title: context.cl.translate(
                                          'pages.auth.signUp.terms',
                                        ),
                                        url: context.cl.translate(
                                          'urls.termsAndConditions',
                                        ),
                                      );
                                    },
                                ),
                                TextSpan(
                                  text:
                                      ' ${context.cl.translate('pages.auth.signUp.and')} ',
                                ),
                                TextSpan(
                                  text: context.cl.translate(
                                    'pages.auth.signUp.privacy',
                                  ),
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      openWebView(
                                        context: context,
                                        title: context.cl.translate(
                                          'pages.auth.signUp.privacy',
                                        ),
                                        url: context.cl.translate(
                                          'urls.privacyPolicy',
                                        ),
                                      );
                                    },
                                ),
                                const TextSpan(text: '.'),
                              ],
                            ),
                          ),
                          value: state.agreeTerms,
                          onChanged: context
                              .read<SignupCubit>()
                              .changeAgreeTerms,
                        ),
                        const SizedBox(height: 24),
                        CustomElevatedButton.inverse(
                          isDisabled:
                              state.password.isEmpty ||
                              state.repeatPassword.isEmpty,
                          onPressed: () => context.read<SignupCubit>().signUp(),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          label: context.cl.translate(
                            'pages.auth.signUp.form.button',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.6,
                                color: context.colors.specificContentLow,
                              ),
                            ),
                            const SizedBox(width: 8),
                            RMText.bodyMedium(
                              context.cl.translate(
                                'pages.auth.signUp.or',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Divider(
                                thickness: 0.6,
                                color: context.colors.specificContentLow,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            if (Platform.isIOS) ...[
                              Expanded(
                                child: CustomIconButton.outline(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  onPressed: () => context
                                      .read<SigninSocialCubit>()
                                      .signInWithApple(),
                                  iconPath: AppAssetsIcons.logoApple,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Expanded(
                              child: CustomIconButton.outline(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                onPressed: () => context
                                    .read<SigninSocialCubit>()
                                    .signInWithGoogle(),
                                iconPath: AppAssetsIcons.logoGoogle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.center,
                          child: CustomTextButton.secondary(
                            onPressed: () => routerApp.pushReplacementNamed(
                              PageNames.signIn,
                            ),
                            label: context.cl.translate(
                              'pages.auth.signUp.amClient',
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
