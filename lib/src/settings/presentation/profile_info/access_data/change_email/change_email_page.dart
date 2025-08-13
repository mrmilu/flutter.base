import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../../../../shared/data/services/http_client.dart';
import '../../../../../shared/domain/failures_extensions/email_failure.extension.dart';
import '../../../../../shared/helpers/toasts.dart';
import '../../../../../shared/presentation/l10n/generated/l10n.dart';
import '../../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../../../shared/presentation/router/app_router.dart';
import '../../../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../../../data/repositories/personal_info_repository_impl.dart';
import '../../../../domain/interfaces/i_personal_info_repository.dart';
import 'change_email_cubit.dart';

class ChangeEmailPage extends StatelessWidget {
  const ChangeEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = getMyHttpClient(context.read<ITokenRepository>());
    return RepositoryProvider<IPersonalInfoRepository>(
      create: (_) => PersonalInfoRepositoryImpl(
        httpClient: httpClient,
        tokenRepository: context.read<ITokenRepository>(),
      ),
      child: BlocProvider(
        create: (context) => ChangeEmailCubit(
          repository: context.read<IPersonalInfoRepository>(),
          globalLoaderCubit: context.read<GlobalLoaderCubit>(),
        ),
        child: const ChangeEmailView(),
      ),
    );
  }
}

class ChangeEmailView extends StatelessWidget {
  const ChangeEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().state.user;
    if (user == null) {
      return const SizedBox.shrink();
    }
    return Scaffold(
      appBar: AppBar(
        title: RMText.titleMedium(
          context.cl.translate('pages.profileInfoAccessDataEmail.title'),
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
              child: BlocBuilder<ChangeEmailCubit, ChangeEmailState>(
                builder: (context, state) {
                  return Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        RMText.bodyMedium(
                          context.cl.translate(
                            'pages.profileInfoAccessDataEmail.subtitle',
                          ),
                          height: 1.5,
                        ),
                        const SizedBox(height: 24),
                        CustomTextFieldWidget(
                          enabled: !state.resultOr.isLoading,
                          labelText: context.cl.translate(
                            'pages.profileInfoAccessDataEmail.form.email',
                          ),
                          showError: state.showError,
                          onChanged: context
                              .read<ChangeEmailCubit>()
                              .changeEmail,
                          errorText: state.email.value.map(
                            isLeft: (p0) => p0.toTranslate(context),
                            isRight: (p0) => null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextFieldWidget(
                          enabled: !state.resultOr.isLoading,
                          labelText: context.cl.translate(
                            'pages.profileInfoAccessDataEmail.form.repeatEmail',
                          ),
                          showError: state.showError,
                          onChanged: context
                              .read<ChangeEmailCubit>()
                              .changeEmailRepeat,
                          errorText:
                              state.emailRepeat != state.email.getOrElse('-1')
                              ? S.of(context).mismatchedEmail
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

class ChangeEmailBottomSheet extends StatelessWidget {
  const ChangeEmailBottomSheet({super.key});

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
        BlocConsumer<ChangeEmailCubit, ChangeEmailState>(
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
                    'pages.profileInfoAccessDataEmail.success',
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            final isDisabled = state.email.getOrElse('');
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomElevatedButton.primary(
                isDisabled: isDisabled == '',
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                onPressed: () => context.read<ChangeEmailCubit>().save(),
                label: context.cl.translate(
                  'pages.profileInfoAccessDataEmail.form.button',
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
            decoration: BoxDecoration(
              color: context.colors.specificBasicBlack,
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
