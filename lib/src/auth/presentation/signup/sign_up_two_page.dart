import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/presentation/extensions/failures/email_failure.extension.dart';
import '../../../shared/presentation/extensions/failures/fullname_failure_extension.dart';
import '../../../shared/presentation/extensions/failures/password_failure_extension.dart';
import '../../../shared/presentation/helpers/toasts.dart';
import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/router/page_names.dart';
import '../../../shared/presentation/utils/assets/app_assets_icons.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/common/image_asset_widget.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../domain/interfaces/i_auth_repository.dart';
import '../extensions/signup_failure_extension.dart';
import '../providers/auth/auth_cubit.dart';
import 'providers/signup_cubit.dart';

class SignUpTwoPage extends StatelessWidget {
  const SignUpTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        authRepository: context.read<IAuthRepository>(),
        authCubit: context.read<AuthCubit>(),
        globalLoaderCubit: context.read<GlobalLoaderCubit>(),
      ),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.user != current.user,
      listener: (context, state) {
        if (state.user != null) {
          routerApp.goNamed(PageNames.mainHome);
        }
      },
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 100,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: context.colors.specificBasicWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 50),
                        const Spacer(),
                        const RMText.bodyLarge('Crea tu cuenta'),
                        const Spacer(),
                        InkWell(
                          onTap: () => routerApp.pop(),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: ImageAssetWidget(
                              path: AppAssetsIcons.close,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                    ),
                    const SizedBox(width: 12),
                    const SizedBox(height: 20),
                    BlocConsumer<SignupCubit, SignupState>(
                      listener: (context, state) {
                        state.resultOr.whenIsFailure(
                          (e) {
                            showError(context, message: e.toTranslate(context));
                          },
                        );
                      },
                      builder: (context, stateSignUp) {
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 4),
                                      CustomTextFieldWidget(
                                        onChanged: context
                                            .read<SignupCubit>()
                                            .changeName,
                                        labelText: 'Nombre',
                                        showError: stateSignUp.showErrors,
                                        errorText: stateSignUp.nameVos.map(
                                          isLeft: (f) => f.toTranslate(context),
                                          isRight: (_) => null,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      CustomTextFieldWidget(
                                        onChanged: context
                                            .read<SignupCubit>()
                                            .changeLastName,
                                        labelText: 'LastName',
                                        showError: stateSignUp.showErrors,
                                        errorText: stateSignUp.lastNameVos.map(
                                          isLeft: (f) => f.toTranslate(context),
                                          isRight: (_) => null,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      CustomTextFieldWidget(
                                        initialValue: stateSignUp.email,
                                        onChanged: context
                                            .read<SignupCubit>()
                                            .changeEmail,
                                        labelText: 'Email',
                                        showError: stateSignUp.showErrors,
                                        errorText: stateSignUp.emailVos.map(
                                          isLeft: (f) => f.toTranslate(context),
                                          isRight: (_) => null,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      CustomTextFieldWidget(
                                        onChanged: context
                                            .read<SignupCubit>()
                                            .changePassword,
                                        labelText: 'Contraseña',
                                        obscureText: false,
                                        showError: stateSignUp.showErrors,
                                        errorText: stateSignUp.passwordVos.map(
                                          isLeft: (f) => f.toTranslate(context),
                                          isRight: (_) => null,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      CustomTextFieldWidget(
                                        enabled:
                                            !stateSignUp.resultOr.isLoading,
                                        obscureText: true,
                                        labelText: 'Repetir Contraseña',
                                        onChanged: context
                                            .read<SignupCubit>()
                                            .changeRepeatPassword,
                                        showError: stateSignUp.showErrors,
                                        errorText:
                                            stateSignUp.repeatPassword !=
                                                stateSignUp.password
                                            ? S.of(context).mismatchedPasswords
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Divider(),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: CustomElevatedButton.inverse(
                                    onPressed: () =>
                                        context.read<SignupCubit>().signUp(),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    label: 'Registrarse',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: MediaQuery.viewInsetsOf(
                                    context,
                                  ).bottom,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
