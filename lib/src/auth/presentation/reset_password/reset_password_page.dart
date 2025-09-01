import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../settings/presentation/profile_info/access_data/change_password/info_password_validator_widget.dart';
import '../../../shared/data/services/app_flyer_service.dart';
import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../../shared/presentation/helpers/toasts.dart';
import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../domain/interfaces/i_auth_repository.dart';
import 'reset_password_cubit.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(
        authRepository: context.read<IAuthRepository>(),
        globalLoaderCubit: context.read<GlobalLoaderCubit>(),
      ),
      child: const ResetPasswordView(),
    );
  }
}

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RMText.titleMedium(
          context.cl.translate('pages.auth.resetPassword.title'),
        ),
      ),
      bottomSheet: const ResetBottomSheet(),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height * 0.6,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                builder: (context, state) {
                  return Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        RMText.bodyMedium(
                          context.cl.translate(
                            'pages.auth.resetPassword.subtitle',
                          ),
                          height: 1.5,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFieldWidget(
                          enabled: !state.resultOr.isLoading,
                          obscureText: true,
                          labelText: context.cl.translate(
                            'pages.auth.resetPassword.form.newPassword',
                          ),
                          onChanged: context
                              .read<ResetPasswordCubit>()
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
                            'pages.auth.resetPassword.form.confirmPassword',
                          ),
                          showError: state.showError,
                          onChanged: context
                              .read<ResetPasswordCubit>()
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
    );
  }
}

class ResetBottomSheet extends StatelessWidget {
  const ResetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1,
          color: context.colors.specificBasicGrey,
        ),
        const SizedBox(height: 20),
        BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
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
                    'pages.auth.resetPassword.success',
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
                onPressed: () => context.read<ResetPasswordCubit>().save(
                  keyGlobalDynamicLink!,
                ),
                label: context.cl.translate(
                  'pages.auth.resetPassword.form.button',
                ),
              ),
            );
          },
        ),
        SizedBox(height: context.paddingBottomPlus),
      ],
    );
  }
}
