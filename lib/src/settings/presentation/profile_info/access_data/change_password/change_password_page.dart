import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../../../../shared/data/services/http_client.dart';
import '../../../../../shared/domain/failures_extensions/password_failure_extension.dart';
import '../../../../../shared/domain/vos/password_vos.dart';
import '../../../../../shared/helpers/toasts.dart';
import '../../../../../shared/presentation/l10n/generated/l10n.dart';
import '../../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../../../shared/presentation/router/app_router.dart';
import '../../../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../../../shared/presentation/utils/styles/colors.dart';
import '../../../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../../../data/repositories/personal_info_repository_impl.dart';
import '../../../../domain/interfaces/i_personal_info_repository.dart';
import 'change_password_cubit.dart';
import 'info_password_validator_widget.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = getMyHttpClient(context.read<ITokenRepository>());
    return RepositoryProvider<IPersonalInfoRepository>(
      create: (_) => PersonalInfoRepositoryImpl(
        httpClient: httpClient,
        tokenRepository: context.read<ITokenRepository>(),
      ),
      child: BlocProvider(
        create: (context) => ChangePasswordCubit(
          repository: context.read<IPersonalInfoRepository>(),
          globalLoaderCubit: context.read<GlobalLoaderCubit>(),
        ),
        child: const ChangePasswordView(),
      ),
    );
  }
}

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().state.user;
    if (user == null) {
      return const SizedBox.shrink();
    }
    return ColoredBox(
      color: AppColors.specificBasicWhite,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: RMText.titleMedium(
              context.cl.translate('pages.profileInfoAccessDataPassword.title'),
            ),
          ),
          bottomSheet: const ChangeEmailBottomSheet(),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                    builder: (context, state) {
                      return Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            RMText.bodyMedium(
                              context.cl.translate(
                                'pages.profileInfoAccessDataPassword.subtitle',
                              ),
                              height: 1.5,
                            ),
                            const SizedBox(height: 20),
                            CustomTextFieldWidget(
                              enabled: !state.resultOr.isLoading,
                              obscureText: true,
                              labelText: context.cl.translate(
                                'pages.profileInfoAccessDataPassword.form.oldPassword',
                              ),
                              onChanged: context
                                  .read<ChangePasswordCubit>()
                                  .changeOldPassword,
                              showError: state.showError,
                              errorText: PasswordVos(state.oldPassword).map(
                                isLeft: (e) => e.toTranslation(context),
                                isRight: (_) => null,
                              ),
                            ),
                            const SizedBox(height: 12),
                            CustomTextFieldWidget(
                              enabled: !state.resultOr.isLoading,
                              obscureText: true,
                              labelText: context.cl.translate(
                                'pages.profileInfoAccessDataPassword.form.password',
                              ),
                              onChanged: context
                                  .read<ChangePasswordCubit>()
                                  .changePassword,
                            ),
                            const SizedBox(height: 4),
                            InfoPasswordValidatorWidget(
                              password: state.password,
                              showError: state.showError,
                            ),
                            const SizedBox(height: 8),
                            CustomTextFieldWidget(
                              enabled: !state.resultOr.isLoading,
                              obscureText: true,
                              labelText: context.cl.translate(
                                'pages.profileInfoAccessDataPassword.form.repeatPassword',
                              ),
                              showError: state.showError,
                              onChanged: context
                                  .read<ChangePasswordCubit>()
                                  .changePasswordRepeat,
                              errorText: state.passwordRepeat != state.password
                                  ? S.of(context).mismatchedPasswords
                                  : null,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChangeEmailBottomSheet extends StatelessWidget {
  const ChangeEmailBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          height: 1,
          color: AppColors.specificBasicGrey,
        ),
        const SizedBox(height: 20),
        BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            state.resultOr.whenIsFailure(
              (failure) => showError(
                context,
                message: failure.toTranslate(context),
              ),
            );
            state.resultOr.whenIsSuccess(
              () {
                routerApp.pop();
                showSuccess(
                  context,
                  message: context.cl.translate(
                    'pages.profileInfoAccessDataPassword.success',
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomElevatedButton.primary(
                isDisabled: state.password.isEmpty,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                onPressed: () => context.read<ChangePasswordCubit>().save(),
                label: context.cl.translate(
                  'pages.profileInfoAccessDataPassword.form.button',
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class GuionText extends StatelessWidget {
  const GuionText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            height: 5,
            width: 5,
            decoration: const BoxDecoration(
              color: AppColors.specificBasicBlack,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: RMText.bodyMedium(
            text,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
