import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/app/ioc/locator.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/router/app_router.dart';
import 'package:flutter_base/ui/styles/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

/// References
/// - EasyLocalization widget test https://github.com/aissat/easy_localization/blob/develop/test/easy_localization_widget_test.dart
extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) async {
    // Initialize environment
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();

    // Mock router
    const path = '/widgetToTest';
    final router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: path,
      errorBuilder: (context, state) {
        debugPrint('Navigate to route ${state.location}');
        return Scaffold(body: Text(state.location));
      },
      routes: [
        GoRoute(
          path: path,
          builder: (_, __) => widget,
        ),
      ],
    );

    await runAsync(() async {
      await pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: UncontrolledProviderScope(
            container: GetIt.I.get<ProviderContainer>(),
            child: ReactiveFormConfig(
              validationMessages: {
                ValidationMessage.required: (_) =>
                    LocaleKeys.errors_form_required.tr(),
                ValidationMessage.email: (_) =>
                    LocaleKeys.errors_form_emailFormat.tr()
              },
              child: Builder(
                builder: (context) {
                  return MaterialApp.router(
                    theme: moggieThemeData,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    scaffoldMessengerKey:
                        GetIt.I.get<GlobalKey<ScaffoldMessengerState>>(),
                    routeInformationParser: router.routeInformationParser,
                    routerDelegate: router.routerDelegate,
                    routeInformationProvider: router.routeInformationProvider,
                  );
                },
              ),
            ),
          ),
        ),
      );
      await pump();
    });
  }
}
