import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/locale/data/locale_repository_impl.dart';
import 'src/locale/domain/i_locale_repository.dart';
import 'src/locale/presentation/providers/locale_cubit.dart';
import 'src/locale/presentation/utils/custom_localization_delegate.dart';
import 'src/shared/presentation/l10n/generated/l10n.dart';
import 'src/shared/presentation/providers/theme_mode/theme_mode_cubit.dart';
import 'src/shared/presentation/utils/styles/themes/theme_dark.dart';
import 'src/shared/presentation/utils/styles/themes/theme_light.dart';
import 'web_content/web_page.dart';

void main() {
  runApp(const AppWeb());
}

class AppWeb extends StatelessWidget {
  const AppWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ILocaleRepository>(
          create: (_) => LocaleRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeModeCubit>(
            create: (context) => ThemeModeCubit(),
          ),
          BlocProvider<LocaleCubit>(
            create: (context) => LocaleCubit(
              localeRepository: context.read<ILocaleRepository>(),
            ),
          ),
        ],
        child: BlocConsumer<ThemeModeCubit, ThemeModeState>(
          listener: (context, state) {
            // SystemUIHelper.setSystemUIForTheme(state.isDarkMode);
          },
          builder: (context, stateTheme) {
            return BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, stateLocale) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: appThemeDataLight,
                  darkTheme: appThemeDataDark,
                  themeMode: stateTheme.isDarkMode
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  localizationsDelegates: [
                    CustomLocalizationDelegate(stateLocale.locale.languageCode),
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  locale: stateLocale.locale,
                  localeResolutionCallback: (locale, supportedLocales) {
                    final localeApp = locale == null
                        ? supportedLocales.first
                        : supportedLocales.contains(locale)
                        ? locale
                        : supportedLocales.first;
                    context.read<LocaleCubit>().loadLocale(
                      localeApp.languageCode,
                    );
                    return localeApp;
                  },
                  supportedLocales: S.delegate.supportedLocales,
                  home: const WebPage(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
