import 'dart:async';

import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/material.dart';
import 'package:flutter_base/src/auth/application/auth_provider.dart';
import 'package:flutter_base/src/shared/application/deep_link_controller.dart';
import 'package:flutter_base/src/shared/application/ui_provider.dart';
import 'package:flutter_base/src/shared/domain/models/app_error.dart';
import 'package:flutter_base/src/shared/domain/use_cases/init_app_use_case.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/theme.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/views/splash_view.dart';
import 'package:flutter_base/src/user/application/user_provider.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/splash.png'), context);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _initAppFuture = _initialize();
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
      if (e.code != AppErrorCode.unauthorized) {
        debugPrintStack(
          label: e.code?.toString() ?? e.message,
          stackTrace: stackTrace,
        );
        Sentry.captureException(e, stackTrace: stackTrace);
        hasError = true;
        rethrow;
      }
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      hasError = true;
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      // swallow error
    } finally {
      if (mounted) {
        setState(() {
          showApp = true;
        });
      }
      await Future.delayed(const Duration(milliseconds: 2000));
      if (mounted) {
        setState(() {
          splashOpacity = 0;
        });
      }
      await Future.delayed(const Duration(milliseconds: 650));
      if (hasError) {
        ref
            .read(uiProvider.notifier)
            .showSnackBar(LocaleKeys.errors_exceptions_global.tr());
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  child: const AppView(),
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
}

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
        router.go('/');
      }
    });

    return ReactiveFormConfig(
      validationMessages: {
        ValidationMessage.required: (_) => LocaleKeys.errors_form_required.tr(),
        ValidationMessage.email: (_) => LocaleKeys.errors_form_emailFormat.tr(),
      },
      child: MaterialApp.router(
        theme: appThemeData,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        scaffoldMessengerKey: GetIt.I.get<GlobalKey<ScaffoldMessengerState>>(),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
