import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../../../shared/data/services/http_client.dart';
import '../../../../shared/domain/failures_extensions/fullname_failure_extension.dart';
import '../../../../shared/domain/types/document_type.dart';
import '../../../../shared/helpers/toasts.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../../shared/presentation/router/app_router.dart';
import '../../../../shared/presentation/utils/call_utils.dart';
import '../../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../../shared/presentation/utils/styles/colors.dart';
import '../../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../../shared/presentation/widgets/components/inputs/custom_dropdown_field_widget.dart';
import '../../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../../data/repositories/personal_info_repository_impl.dart';
import '../../../domain/interfaces/i_personal_info_repository.dart';
import 'personal_data_cubit.dart';

class ProfileInfoPersonalDataPage extends StatelessWidget {
  const ProfileInfoPersonalDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = getMyHttpClient(context.read<ITokenRepository>());
    final user = context.read<AuthCubit>().state.user;
    return RepositoryProvider<IPersonalInfoRepository>(
      create: (_) => PersonalInfoRepositoryImpl(
        httpClient: httpClient,
        tokenRepository: context.read<ITokenRepository>(),
      ),
      child: BlocProvider(
        create: (context) => PersonalDataCubit(
          repository: context.read<IPersonalInfoRepository>(),
          globalLoaderCubit: context.read<GlobalLoaderCubit>(),
        )..init(user),
        child: const ProfileInfoPersonalDataView(),
      ),
    );
  }
}

class ProfileInfoPersonalDataView extends StatelessWidget {
  const ProfileInfoPersonalDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().state.user;
    if (user == null) {
      return const SizedBox.shrink();
    }
    return Scaffold(
      appBar: AppBar(
        title: RMText.titleMedium(
          context.cl.translate('pages.profileInfoPersonalData.title'),
        ),
      ),
      bottomSheet: const PersonalDataBottomSheet(),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BlocBuilder<PersonalDataCubit, PersonalDataState>(
                builder: (context, state) {
                  return Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        RMText.bodySmall(
                          context.cl.translate(
                            'pages.profileInfoPersonalData.subtitle',
                          ),
                          height: 1.5,
                        ),
                        const SizedBox(height: 32),
                        CustomTextFieldWidget(
                          readOnly: true,
                          enabled: !state.resultOrPersonalData.isLoading,
                          initialValue: state.name.getOrElse(''),
                          labelText: context.cl.translate(
                            'pages.profileInfoPersonalData.form.name',
                          ),
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          showError: state.showError,
                          onChanged: context
                              .read<PersonalDataCubit>()
                              .changeName,
                          errorText: state.name.value.map(
                            isLeft: (p0) => p0.toTranslation(context),
                            isRight: (p0) => null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextFieldWidget(
                          readOnly: true,
                          enabled: !state.resultOrPersonalData.isLoading,
                          initialValue: state.lastName.getOrElse(''),
                          labelText: context.cl.translate(
                            'pages.profileInfoPersonalData.form.surname',
                          ),
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          showError: state.showError,
                          onChanged: context
                              .read<PersonalDataCubit>()
                              .changeLastName,
                          errorText: state.lastName.value.map(
                            isLeft: (p0) => p0.toTranslation(context),
                            isRight: (p0) => null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomDropdownFieldWidget<DocumentType>(
                          title: context.cl.translate(
                            'pages.profileInfoPersonalData.form.documentType',
                          ),
                          onChanged: (value) {},
                          readOnly: true,
                          initialValue: user.document?.$1.toTranslate(
                            context,
                          ),
                          value: user.document?.$1,
                          items: [
                            DropdownMenuItem(
                              value: DocumentType.nif,
                              child: Text(
                                DocumentType.nif.toTranslate(context),
                              ),
                            ),
                            DropdownMenuItem(
                              value: DocumentType.nie,
                              child: Text(
                                DocumentType.nie.toTranslate(context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CustomTextFieldWidget(
                          initialValue: user.document?.$2 ?? '',
                          onChanged: (value) {},
                          readOnly: true,
                          labelText: context.cl.translate(
                            'pages.profileInfoPersonalData.form.documentNumber',
                          ),
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

class PersonalDataBottomSheet extends StatelessWidget {
  const PersonalDataBottomSheet({super.key});

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
        BlocConsumer<PersonalDataCubit, PersonalDataState>(
          listener: (context, state) {
            state.resultOrPersonalData.whenIsFailure(
              (e) => showError(context, message: e.toTranslate(context)),
            );
            state.resultOrPersonalData.whenIsSuccess(
              () {
                routerApp.pop();
                showSuccess(
                  context,
                  message: context.cl.translate(
                    'pages.profileInfoPersonalData.success',
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            // final isChanged = context.read<PersonalDataCubit>().isChanged();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomElevatedButton.inverse(
                // isDisabled: !isChanged,
                // onPressed: () => context.read<PersonalDataCubit>().save(),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                onPressed: () => callSupport(context),
                label: context.cl.translate(
                  'pages.profileInfoPersonalData.form.button',
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
