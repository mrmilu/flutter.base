import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/material.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/core/app/domain/use_cases/init_app_use_case.dart';
import 'package:flutter_base/ui/components/views/splash_view.dart';
import 'package:flutter_base/ui/controllers/deep_link_controller.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/styles/theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with TickerProviderStateMixin {
  late AnimationController _controller;
  double splashOpacity = 1;
  bool showApp = false;
  late Future _initAppFuture;

  @override
  void initState() {
    precacheImage(const AssetImage('assets/images/splash.png'), context);
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _initAppFuture = _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initAppFuture,
      builder: (context, snapshot) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              Positioned.fill(
                child: Visibility(
                  visible: showApp,
                  child: _MaterialApp(),
                ),
              ),
              if (snapshot.connectionState == ConnectionState.waiting)
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: splashOpacity,
                    duration: const Duration(milliseconds: 500),
                    child: MaterialApp(
                      home: SplashView(controller: _controller),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _initialize() async {
    bool hasError = false;
    _controller.repeat();
    GetIt.I.get<DeepLinkController>()();
    FlutterNativeSplash.remove();
    try {
      await ref.read(userProvider.notifier).getInitialUserData();
      final initAppUseCase = GetIt.I.get<InitAppUseCase>();
      await initAppUseCase();
    } on AppError catch (e, stackTrace) {
      if (e.code != AppErrorCode.unAuthorized) {
        log(e.code?.toString() ?? e.message ?? 'Init error');
        Sentry.captureException(e, stackTrace: stackTrace);
        hasError = true;
        rethrow;
      }
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      hasError = true;
      log('$runtimeType/${e.toString()}');
      // swallow error
    } finally {
      setState(() {
        showApp = true;
      });
      await Future.delayed(const Duration(milliseconds: 2000));
      setState(() {
        splashOpacity = 0;
      });
      await Future.delayed(const Duration(milliseconds: 650));
      if (hasError) {
        ref
            .read(uiProvider.notifier)
            .showSnackBar(LocaleKeys.errorsMessages_global.tr());
      }
    }
  }
}

class _MaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReactiveFormConfig(
      validationMessages: {
        ValidationMessage.required: (_) => LocaleKeys.formErrors_required.tr(),
        ValidationMessage.email: (_) => LocaleKeys.formErrors_emailFormat.tr()
      },
      child: MaterialApp.router(
        theme: moggieThemeData,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        scaffoldMessengerKey: GetIt.I.get<GlobalKey<ScaffoldMessengerState>>(),
        routeInformationParser: GetIt.I.get<GoRouter>().routeInformationParser,
        routerDelegate: GetIt.I.get<GoRouter>().routerDelegate,
        routeInformationProvider:
            GetIt.I.get<GoRouter>().routeInformationProvider,
      ),
    );
  }
}
