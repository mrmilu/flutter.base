// ignore_for_file: depend_on_referenced_packages

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/app.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/router/app_router.dart';
import 'package:flutter_base/ui/styles/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import '../ioc/locator_mock.dart';
import 'fake/fake_video_player_platform.dart';

/// References
/// - EasyLocalization widget test https://github.com/aissat/easy_localization/blob/develop/test/easy_localization_widget_test.dart
extension PumpApp on WidgetTester {
  /// Pump any widget with app configuration and mock router
  /// You need call [configureMockDependencies] before call [pumpAppWidget]
  /// [configureMockDependencies] is outside to configure the mocks at a general level on each test file
  Future<void> pumpAppWidget(Widget widget) async {
    await _preInitialization();

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

    await _pumpApp(router);
    await pumpAndSettle();
  }

  /// Pump any route include in GoRouter with app configuration
  /// You need call [configureMockDependencies] before call [pumpAppWidget]
  /// [configureMockDependencies] is outside to configure the mocks at a general level on each test file
  Future<void> pumpAppRoute(String? location, {Object? extra}) async {
    await _preInitialization();
    await _pumpApp();
    await pumpAndSettle();
    if (location != null) {
      getIt<GoRouter>().go(location, extra: extra);
      await pumpAndSettle();
    }
  }

  Future<void> _pumpApp([GoRouter? router]) async {
    await runAsync(() async {
      await pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: UncontrolledProviderScope(
            container: GetIt.I.get<ProviderContainer>(),
            child: FutureBuilder(
              future: getIt<ProviderContainer>()
                  .read(userProvider.notifier)
                  .getInitialUserData(),
              builder: (context, snapshot) {
                return router == null
                    ? const AppView()
                    : ReactiveFormConfig(
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
                              getIt<GlobalKey<ScaffoldMessengerState>>(),
                          routeInformationParser: router.routeInformationParser,
                          routerDelegate: router.routerDelegate,
                          routeInformationProvider:
                              router.routeInformationProvider,
                        ),
                      );
              },
            ),
          ),
        ),
      );
    });
  }

  Future<void> _preInitialization() async {
    // DISCLAIMER this is only necessary to mock video player and not throw exception
    VideoPlayerPlatform.instance = FakeVideoPlayerPlatform();
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  }
}
