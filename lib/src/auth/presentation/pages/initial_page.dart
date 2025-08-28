import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/data/services/app_flyer_service.dart';
import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../../shared/presentation/helpers/toasts.dart';
import '../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/router/page_names.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../domain/failures/oauth_sign_in_failure.dart';
import '../../domain/interfaces/i_auth_repository.dart';
import '../extensions/oauth_sign_in_failure_extension.dart';
import '../extensions/signin_failure_extension.dart';
import '../extensions/signup_failure_extension.dart';
import '../extensions/update_document_failure_extension.dart';
import '../extensions/validate_email_failure_extension.dart';
import '../providers/auth/auth_cubit.dart';
import '../providers/forgot_password/forgot_password_cubit.dart';
import '../providers/link_encoded/link_encoded_cubit.dart';
import '../providers/reset_password/reset_password_cubit.dart';
import '../providers/signin_social/signin_social_cubit.dart';
import '../providers/update_document/update_document_cubit.dart';
import '../providers/validate_email/validate_email_cubit.dart';
import '../signin/providers/signin_cubit.dart';
import '../signup/providers/signup_cubit.dart';
import '../widgets/initial_content_check_email_to_password_widget.dart';
import '../widgets/initial_content_confirm_your_account_widget.dart';
import '../widgets/initial_content_forgot_password_widget.dart';
import '../widgets/initial_content_reset_password_widget.dart';
import '../widgets/initial_content_signin_email_password_widget.dart';
import '../widgets/initial_content_signin_email_widget.dart';
import '../widgets/initial_content_signup_email_password_widget.dart';
import '../widgets/initial_content_signup_email_widget.dart';
import '../widgets/initial_content_update_document_widget.dart';

enum InitialStep {
  signInEmail,
  signInEmailPassword,
  signUpEmail,
  signUpEmailPassword,
  confirmYourAccount,
  updateDocument,
  forgetPassword,
  checkEmailToPassword,
  updatePassword,
}

class InitialPage2 extends StatelessWidget {
  const InitialPage2({super.key, this.initialStep = 0});
  final int initialStep;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SigninCubit(
            authRepository: context.read<IAuthRepository>(),
            globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          ),
        ),
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
        BlocProvider(
          create: (context) => ValidateEmailCubit(
            authRepository: context.read<IAuthRepository>(),
            globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => LinkEncodedCubit(
            authRepository: context.read<IAuthRepository>(),
            globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateDocumentCubit(
            authRepository: context.read<IAuthRepository>(),
            authCubit: context.read<AuthCubit>(),
            globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordCubit(
            authRepository: context.read<IAuthRepository>(),
            globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => ResetPasswordCubit(
            authRepository: context.read<IAuthRepository>(),
            globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          ),
        ),
      ],
      child: InitialView(initialStep: initialStep),
    );
  }
}

class InitialView extends StatefulWidget {
  const InitialView({super.key, required this.initialStep});
  final int initialStep;

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  late ValueNotifier<int> currentStep;

  @override
  void initState() {
    currentStep = ValueNotifier<int>(widget.initialStep);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      manageDeepLink();
    });

    AppFlyerService().onDeepLinkingWithRedirectInitialPage(
      context,
      currentStep,
    );
  }

  @override
  void dispose() {
    currentStep.dispose();
    super.dispose();
  }

  void manageDeepLink() async {
    if (typeGlobalDynamicLink != null && keyGlobalDynamicLink != null) {
      if (typeGlobalDynamicLink == dynamicLinkTypeValidateEmail) {
        context.read<ValidateEmailCubit>().validateEmail(keyGlobalDynamicLink!);
      }
      if (typeGlobalDynamicLink == dynamicLinkTypeResetPassword) {
        currentStep.value = InitialStep.updatePassword.index;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final insetBottom = MediaQuery.viewInsetsOf(context).bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: const Key('initial_page'),
        resizeToAvoidBottomInset: false,
        backgroundColor: context.colors.specificBackgroundOverlay2,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 20,
              child: SafeArea(
                child: InkWell(
                  onTap: () {
                    routerApp.pushNamed(PageNames.signIn);
                  },
                  child: const Center(
                    child: RMText.displayLarge('Flutter base'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: context.paddingBottomPlus,
                color: context.colors.specificBasicWhite,
              ),
            ),
            Positioned(
                  bottom: currentStep.value == 0 || currentStep.value == 2
                      ? insetBottom > 160
                            ? MediaQuery.viewInsetsOf(context).bottom - 160
                            : 0
                      : insetBottom > 0
                      ? MediaQuery.viewInsetsOf(context).bottom
                      : 0,
                  left: 0,
                  right: 0,
                  child: MultiBlocListener(
                    listeners: [
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) async {
                          if (state.user != null) {
                            if (!state.user!.isValidated) {
                              currentStep.value =
                                  InitialStep.confirmYourAccount.index;
                              return;
                            }
                            routerApp.goNamed(PageNames.mainHome);
                          }
                        },
                      ),
                      BlocListener<SigninCubit, SigninState>(
                        listenWhen: (previous, current) =>
                            previous.resultOr != current.resultOr,
                        listener: (context, state) {
                          state.resultOr.whenIsFailure(
                            (e) => showError(
                              context,
                              message: e.toTranslate(context),
                            ),
                          );
                          state.resultOr.whenIsSuccess(
                            () async {
                              await context.read<AuthCubit>().loginUser();
                            },
                          );
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
                      BlocListener<ValidateEmailCubit, ValidateEmailState>(
                        listener: (context, state) {
                          state.resultOr.whenIsFailure(
                            (e) => showError(
                              context,
                              message: e.toTranslate(context),
                            ),
                          );
                          state.resultOr.whenIsSuccess(
                            () {
                              context.read<AuthCubit>().reloadUser();
                            },
                          );
                        },
                      ),
                      BlocListener<LinkEncodedCubit, LinkEncodedState>(
                        listener: (context, state) {
                          state.resultOr.whenIsFailure(
                            (e) => showError(
                              context,
                              message: e.toTranslate(context),
                            ),
                          );
                          state.resultOr.whenIsSuccess(
                            () {
                              if (routerApp.canPop()) {
                                routerApp.pop();
                              }
                              context.read<AuthCubit>().reloadUser();
                            },
                          );
                        },
                      ),
                      BlocListener<UpdateDocumentCubit, UpdateDocumentState>(
                        listener: (context, state) {
                          state.resultOr.whenIsFailure(
                            (e) => showError(
                              context,
                              message: e.toTranslate(context),
                            ),
                          );
                          state.resultOr.whenIsSuccess(
                            () {
                              context
                                ..read<AuthCubit>().createTokenDevice()
                                ..read<AuthCubit>().reloadUser();
                            },
                          );
                        },
                      ),
                      BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                        listenWhen: (previous, current) =>
                            previous.resultOr != current.resultOr,
                        listener: (context, state) {
                          state.resultOr.whenIsFailure(
                            (e) => showError(
                              context,
                              message: e.toTranslate(context),
                            ),
                          );
                          state.resultOr.whenIsSuccess(
                            () {
                              currentStep.value =
                                  InitialStep.checkEmailToPassword.index;
                            },
                          );
                        },
                      ),
                      BlocListener<ResetPasswordCubit, ResetPasswordState>(
                        listener: (context, state) {
                          state.resultOr.whenIsFailure(
                            (e) => showError(
                              context,
                              message: e.toTranslate(context),
                            ),
                          );
                          state.resultOr.whenIsSuccess(
                            () {
                              context.read<AuthCubit>().loginUser();
                            },
                          );
                        },
                      ),
                    ],
                    child: Center(
                      child: SafeArea(
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.colors.specificBasicWhite,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: AnimatedSize(
                            alignment: Alignment.topCenter,
                            duration: 240.ms,
                            child: ValueListenableBuilder(
                              valueListenable: currentStep,
                              builder: (context, value, child) {
                                if (value == InitialStep.signInEmail.index) {
                                  return InitialContentSignInEmailWidget(
                                    currentStep: currentStep,
                                  );
                                }
                                if (value ==
                                    InitialStep.signInEmailPassword.index) {
                                  return InitialContentSignInEmailPasswordWidget(
                                    currentStep: currentStep,
                                  );
                                }
                                if (value == InitialStep.signUpEmail.index) {
                                  return InitialContentSignUpEmailWidget(
                                    currentStep: currentStep,
                                  );
                                }
                                if (value ==
                                    InitialStep.signUpEmailPassword.index) {
                                  return InitialContentSignUpEmailPasswordWidget(
                                    currentStep: currentStep,
                                  );
                                }
                                if (value ==
                                    InitialStep.confirmYourAccount.index) {
                                  return InitialContentConfirmYourAccountWidget(
                                    currentStep: currentStep,
                                  );
                                }
                                if (value == InitialStep.updateDocument.index) {
                                  return InitialContentUpdateDocumentWidget(
                                    currentStep: currentStep,
                                  );
                                }
                                if (value ==
                                    InitialStep.checkEmailToPassword.index) {
                                  return InitialContentCheckEmailToPasswordWidget(
                                    currentStep: currentStep,
                                  );
                                }
                                if (value == InitialStep.forgetPassword.index) {
                                  return InitialContentForgotPasswordWidget(
                                    currentStep: currentStep,
                                  );
                                }
                                if (value == InitialStep.updatePassword.index) {
                                  return InitialContentResetPasswordWidget(
                                    currentStep: currentStep,
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .animate(key: const ValueKey('initialContent'))
                .slideY(
                  begin: 1,
                  end: 0,
                  duration: 500.ms,
                ),
          ],
        ),
      ),
    );
  }
}
