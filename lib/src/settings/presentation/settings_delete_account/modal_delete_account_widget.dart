import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../auth/presentation/pages/initial_page.dart';
import '../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../../shared/data/services/http_client.dart';
import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/helpers/toasts.dart';
import '../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/router/page_names.dart';
import '../../../shared/presentation/utils/const.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/common/point_with_text_widget.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_outlined_button.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../../shared/presentation/widgets/wrapper_bottom_sheet_with_button.dart';
import '../../data/repositories/delete_account_repository_impl.dart';
import '../../domain/interfaces/i_delete_account_repository.dart';
import 'providers/delete_account_cubit.dart';

Future<dynamic> showModalDeleteAccount(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    routeSettings: const RouteSettings(name: PageNames.modalDeleteAccount),
    builder: (context) => Padding(
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
      child: WrapperBottomSheetWithButton(
        title: context.cl.translate('modals.deleteAccount.title'),
        child: const ModalDeleteAccountWidget(),
      ),
    ),
  );
}

class ModalDeleteAccountWidget extends StatelessWidget {
  const ModalDeleteAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = getMyHttpClient(context.read<ITokenRepository>());
    return RepositoryProvider<IDeleteAccountRepository>(
      create: (_) => DeleteAccountRepositoryImpl(httpClient),
      child: BlocProvider(
        create: (context) => DeleteAccountCubit(
          repository: context.read<IDeleteAccountRepository>(),
          globalLoaderCubit: context.read<GlobalLoaderCubit>(),
        ),
        child: const ModalDeleteAccountWidgetContent(),
      ),
    );
  }
}

class ModalDeleteAccountWidgetContent extends StatelessWidget {
  const ModalDeleteAccountWidgetContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.user != current.user && current.user == null,
      listener: (context, state) {
        if (state.user == null) {
          routerApp.goNamed(
            PageNames.initial,
            extra: InitialStep.signInEmail.index,
          );
        }
      },
      child: BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
        listenWhen: (previous, current) =>
            previous.resultOr != current.resultOr,
        listener: (context, state) {
          state.resultOr.whenIsFailure(
            (failure) =>
                showError(context, message: failure.toTranslate(context)),
          );
          state.resultOr.whenIsSuccess(() {
            context.read<AuthCubit>().logout();
          });
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        RMText.titleSmall(
                          context.cl.translate('modals.deleteAccount.subtitle'),
                          height: 1.5,
                        ),
                        const SizedBox(height: 20),
                        RMText.bodyMedium(
                          context.cl.translate(
                            'modals.deleteAccount.description.first',
                          ),
                          height: 1.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: PointWithTextWidget(
                            title: context.cl.translate(
                              'modals.deleteAccount.description.second',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: PointWithTextWidget(
                            title: context.cl.translate(
                              'modals.deleteAccount.description.third',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: PointWithTextWidget(
                            title: context.cl.translate(
                              'modals.deleteAccount.description.fourth',
                            ),
                          ),
                        ),
                        RMText.bodyMedium(
                          context.cl.translate('modals.deleteAccount.warning'),
                          height: 1.5,
                        ),
                        const SizedBox(height: 20),
                        RMText.titleSmall(
                          context.cl.translate(
                            'modals.deleteAccount.confirmation',
                          ),
                          height: 1.5,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomElevatedButton.inverse(
                  backgroundColor: context.colors.specificSemanticError,
                  padding: const EdgeInsets.symmetric(
                    vertical: paddingHightButtons,
                  ),
                  onPressed: () =>
                      context.read<DeleteAccountCubit>().deleteAccount(),
                  label: context.cl.translate(
                    'modals.deleteAccount.button.confirm',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomOutlinedButton.primary(
                  padding: const EdgeInsets.symmetric(
                    vertical: paddingHightButtons,
                  ),
                  onPressed: () => routerApp.pop(),
                  label: context.cl.translate(
                    'modals.deleteAccount.button.cancel',
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }
}
