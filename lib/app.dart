import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'flavors.dart';
import 'src/auth/data/repositories/auth_repository_impl.dart';
import 'src/auth/data/repositories/secure_storage_service.dart';
import 'src/auth/data/repositories/token_repository.dart';
import 'src/auth/domain/interfaces/i_auth_repository.dart';
import 'src/auth/domain/interfaces/i_token_repository.dart';
import 'src/auth/presentation/providers/auth/auth_cubit.dart';
import 'src/locale/data/locale_repository_impl.dart';
import 'src/locale/domain/i_locale_repository.dart';
import 'src/locale/presentation/providers/locale_cubit.dart';
import 'src/locale/presentation/utils/custom_localization_delegate.dart';
import 'src/shared/data/repositories/download_file_repository_impl.dart';
import 'src/shared/data/repositories/settings_repository_impl.dart';
import 'src/shared/data/services/http_client.dart';
import 'src/shared/domain/interfaces/i_download_file_repository.dart';
import 'src/shared/domain/interfaces/i_settings_repository.dart';
import 'src/shared/presentation/l10n/generated/l10n.dart';
import 'src/shared/presentation/pages/app_status_page.dart';
import 'src/shared/presentation/providers/global_loader/global_loader_cubit.dart';
import 'src/shared/presentation/providers/theme_mode/theme_mode_cubit.dart';
import 'src/shared/presentation/router/app_router.dart';
import 'src/shared/presentation/utils/styles/theme.dart';
import 'src/splash/presentation/providers/app_settings_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Token user
        RepositoryProvider<ITokenRepository>(
          create: (_) => TokenRepositoryImpl(
            SecureStorageService(),
            Dio(baseOptions),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          final httpClient = getMyHttpClient(context.read<ITokenRepository>());
          return MultiRepositoryProvider(
            providers: [
              // Locale
              RepositoryProvider<ILocaleRepository>(
                create: (_) => LocaleRepositoryImpl(),
              ),
              // App Settings
              RepositoryProvider<ISettingsRepository>(
                create: (_) => SettingsRepositoryImpl(httpClient),
              ),
              // Auth
              RepositoryProvider<IAuthRepository>(
                create: (_) => AuthRepositoryImpl(
                  tokenRepository: context.read<ITokenRepository>(),
                  firebaseAuth: FirebaseAuth.instance,
                  httpClient: httpClient,
                ),
              ),
              // Dowlonad file
              RepositoryProvider<IDownloadFileRepository>(
                create: (_) => DownloadFileRepositoryImpl(httpClient),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<GlobalLoaderCubit>(
                  create: (context) => GlobalLoaderCubit(),
                ),
                // BlocProvider<ConnectivityCubit>(
                //   create: (context) => ConnectivityCubit()..init(),
                // ),
                BlocProvider<AppSettingsCubit>(
                  create: (context) => AppSettingsCubit(
                    repository: context.read<ISettingsRepository>(),
                  ),
                ),
                BlocProvider<ThemeModeCubit>(
                  create: (context) => ThemeModeCubit(),
                ),
                BlocProvider<LocaleCubit>(
                  create: (context) => LocaleCubit(
                    localeRepository: context.read<ILocaleRepository>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => AuthCubit(
                    authRepository: context.read<IAuthRepository>(),
                    globalLoaderCubit: context.read<GlobalLoaderCubit>(),
                  ),
                ),
              ],
              child: const AppView(),
            ),
          );
        },
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeModeCubit, ThemeModeState>(
      listener: (context, state) {
        // SystemUIHelper.setSystemUIForTheme(state.isDarkMode);
      },
      builder: (context, stateTheme) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, stateLocale) {
            return MaterialApp.router(
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
                context.read<LocaleCubit>().loadLocale(localeApp.languageCode);
                return localeApp;
              },
              supportedLocales: S.delegate.supportedLocales,
              routerDelegate: routerApp.routerDelegate,
              routeInformationParser: routerApp.routeInformationParser,
              routeInformationProvider: routerApp.routeInformationProvider,
              builder: (context, child) {
                return FlavorBanner(
                  show: !kReleaseMode,
                  child: Stack(
                    children: [
                      child!,
                      BlocBuilder<AppSettingsCubit, AppSettingsState>(
                        builder: (context, stateSettings) {
                          return stateSettings.resource.map(
                            isNone: () => const SizedBox.shrink(),
                            isLoading: () => const SizedBox.shrink(),
                            isFailure: (_) => const SizedBox.shrink(),
                            isSuccess: (resource) =>
                                AppStatusPage(status: resource.status),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class FlavorBanner extends StatelessWidget {
  const FlavorBanner({super.key, required this.child, this.show = true});
  final Widget child;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return show
        ? Banner(
            location: BannerLocation.topStart,
            message: F.name,
            color: Colors.green.withAlpha((0.6 * 255).toInt()),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.0,
              letterSpacing: 1.0,
            ),
            textDirection: TextDirection.ltr,
            child: child,
          )
        : child;
  }
}
