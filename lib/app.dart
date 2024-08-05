import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/material.dart';
import 'package:flutter_base/src/auth/application/auth_provider.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

@visibleForTesting
// ignore: prefer-single-widget-per-file
class AppView extends ConsumerWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GetIt.I.get<GoRouter>();

    ref.listen(authProvider, (previous, next) {
      if (previous == AuthStatus.authenticated &&
          next == AuthStatus.unauthenticated) {
        router.go('/initial');
      }
    });

    return Directionality(
      textDirection: TextDirection.ltr,
      child: ReactiveFormConfig(
        validationMessages: {
          ValidationMessage.required: (_) =>
              LocaleKeys.errors_form_required.tr(),
          ValidationMessage.email: (_) =>
              LocaleKeys.errors_form_emailFormat.tr(),
        },
        child: MaterialApp.router(
          theme: appThemeData,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          scaffoldMessengerKey:
              GetIt.I.get<GlobalKey<ScaffoldMessengerState>>(),
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
        ),
      ),
    );
  }
}
