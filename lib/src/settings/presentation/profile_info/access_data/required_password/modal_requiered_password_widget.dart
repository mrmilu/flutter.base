import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../../../shared/data/services/http_client.dart';
import '../../../../../shared/helpers/toasts.dart';
import '../../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../../../shared/presentation/router/app_router.dart';
import '../../../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../../data/repositories/personal_info_repository_impl.dart';
import '../../../../domain/interfaces/i_personal_info_repository.dart';
import 'required_password_cubit.dart';

class ModalRequiredPassword extends StatelessWidget {
  const ModalRequiredPassword({
    super.key,
    required this.title,
    required this.textButton,
  });
  final String title;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    final httpClient = getMyHttpClient(context.read<ITokenRepository>());
    return RepositoryProvider<IPersonalInfoRepository>(
      create: (_) => PersonalInfoRepositoryImpl(
        httpClient: httpClient,
        tokenRepository: context.read<ITokenRepository>(),
      ),
      child: BlocProvider(
        create: (context) => RequiredPasswordCubit(
          repository: context.read<IPersonalInfoRepository>(),
          globalLoaderCubit: context.read<GlobalLoaderCubit>(),
        ),
        child: ModalRequiredPasswordContent(
          title: title,
          textButton: textButton,
        ),
      ),
    );
  }
}

class ModalRequiredPasswordContent extends StatelessWidget {
  const ModalRequiredPasswordContent({
    super.key,
    required this.title,
    required this.textButton,
  });
  final String title;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequiredPasswordCubit, RequiredPasswordState>(
      listenWhen: (previous, current) => previous.resultOr != current.resultOr,
      listener: (context, state) {
        state.resultOr.whenIsFailure((failure) {
          showError(context, message: failure.toTranslate(context));
        });
        state.resultOr.whenIsSuccess(() {
          routerApp.pop(true);
        });
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(title),
                  const SizedBox(height: 20),
                  CustomTextFieldWidget(
                    autofocus: true,
                    obscureText: true,
                    labelText: context.cl.translate(
                      'modals.changePassword.form.password',
                    ),
                    onChanged: context
                        .read<RequiredPasswordCubit>()
                        .changePassword,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomElevatedButton.primary(
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: () => context.read<RequiredPasswordCubit>().save(),
                label: textButton,
                isDisabled: state.password.isEmpty,
              ),
            ),
            SizedBox(height: context.paddingBottomPlus),
          ],
        );
      },
    );
  }
}
