import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/extensions/color_extension.dart';
import '../../../shared/presentation/extensions/failures/email_failure.extension.dart';
import '../../../shared/presentation/helpers/toasts.dart';
import '../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../domain/interfaces/i_auth_repository.dart';
import '../extensions/signin_failure_extension.dart';
import 'forgot_password_cubit.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ForgotPasswordCubit(
            authRepository: context.read<IAuthRepository>(),
            globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          ),
        ),
      ],
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RMText.titleMedium(
          context.cl.translate(
            'pages.auth.forgotPassword.title',
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            state.resultOr.whenIsFailure(
              (e) => showError(
                context,
                message: e.toTranslate(context),
              ),
            );
            state.resultOr.whenIsSuccess(
              () {},
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
                          color: context.colors.specificContentLow,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Center(
                      child: RMText.titleLarge(
                        context.cl.translate(
                          'pages.auth.forgotPassword.forgotPassword',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: RMText.bodyMedium(
                        context.cl.translate(
                          'pages.auth.forgotPassword.subtitle',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomTextFieldWidget(
                      initialValue: state.email,
                      onChanged: context
                          .read<ForgotPasswordCubit>()
                          .changeEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,

                      labelText: context.cl.translate(
                        'pages.auth.signUp.form.email',
                      ),
                      showError: state.showErrors,
                      errorText: state.emailVos.map(
                        isLeft: (e) => e.toTranslate(context),
                        isRight: (_) => null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomElevatedButton.inverse(
                      onPressed: () =>
                          context.read<ForgotPasswordCubit>().forgotPassword(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      label: context.cl.translate(
                        'pages.auth.forgotPassword.form.button',
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () => routerApp.pop(),
                      child: Text.rich(
                        TextSpan(
                          text:
                              '${context.cl.translate(
                                'pages.auth.forgotPassword.rememberYourPassword',
                              )} ',
                          children: [
                            TextSpan(
                              text: context.cl.translate(
                                'pages.auth.forgotPassword.signIn',
                              ),
                              style: TextStyle(
                                color: context.colors.specificSemanticSuccess,
                              ),
                            ),
                          ],
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        const SizedBox(width: 8),
                        RMText.bodyMedium(
                          context.cl.translate(
                            'pages.auth.forgotPassword.or',
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        color: context.colors.specificContentLow.wOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          Center(
                            child: RMText.bodyMedium(
                              context.cl.translate(
                                'pages.auth.forgotPassword.stillTrouble',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: CustomTextButton.secondary(
                              label: context.cl.translate(
                                'pages.auth.forgotPassword.contactSupport',
                              ),
                              textStyle: context.textTheme.bodyMedium?.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
