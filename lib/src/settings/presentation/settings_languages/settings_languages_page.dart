import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../locale/presentation/providers/locale_cubit.dart';
import '../../../shared/data/services/http_client.dart';
import '../../../shared/helpers/toasts.dart';
import '../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_dropdown_field_package_widget.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../data/repositories/change_language_repository_impl.dart';
import '../../domain/interfaces/i_change_language_repository.dart';
import '../../domain/types/app_language_type.dart';
import 'providers/change_language_cubit.dart';

class SettingsLanguagesPage extends StatelessWidget {
  const SettingsLanguagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = getMyHttpClient(context.read<ITokenRepository>());
    return RepositoryProvider<IChangeLanguageRepository>(
      create: (_) => ChangeLanguageRepositoryImpl(httpClient),
      child: BlocProvider(
        create: (context) => ChangeLanguageCubit(
          repository: context.read<IChangeLanguageRepository>(),
          globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          localeCubit: context.read<LocaleCubit>(),
        ),
        child: const SettingsLanguagesView(),
      ),
    );
  }
}

class SettingsLanguagesView extends StatelessWidget {
  const SettingsLanguagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeLanguageCubit, ChangeLanguageState>(
      listener: (context, state) {
        state.resultOr.whenIsFailure(
          (failure) {
            showError(context, message: failure.toTranslate(context));
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: RMText.titleMedium(
            context.cl.translate('pages.profileInfoConfigLanguages.title'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                RMText.bodyMedium(
                  context.cl.translate(
                    'pages.profileInfoConfigLanguages.subtitle',
                  ),
                  height: 1.5,
                ),
                const SizedBox(height: 20),
                BlocBuilder<LocaleCubit, LocaleState>(
                  builder: (context, stateLocale) {
                    final myLocale = AppLanguageType.values.firstWhereOrNull(
                      (element) => element.name == stateLocale.languageCode,
                    );
                    return CustomDropdownFieldPackageWidget<AppLanguageType>(
                      title: context.cl.translate(
                        'pages.profileInfoConfigLanguages.form.language',
                      ),
                      value: myLocale,
                      initialValue: myLocale?.toTranslate(context),
                      items: AppLanguageType.values
                          .map(
                            (item) => DropdownMenuItem<AppLanguageType>(
                              value: item,
                              child: Text(
                                item.toTranslate(context),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: stateLocale.languageCode == item.name
                                      ? Colors.grey
                                      : null,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (p0) {
                        context.read<ChangeLanguageCubit>().changeLanguage(
                          p0.name,
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: context.paddingBottomPlus),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
