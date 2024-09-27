import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/src/shared/application/use_cases/init_app_use_case.dart';
import 'package:flutter_base/src/shared/domain/models/app_error.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/router/app_router.dart';
import 'package:flutter_base/src/shared/presentation/states/ui_provider.dart';
import 'package:flutter_base/src/user/presentation/states/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SplashNotifier extends AutoDisposeNotifier<void> {
  final _initAppUseCase = GetIt.I.get<InitAppUseCase>();
  bool hasError = false;

  @override
  void build() {}

  void init() async {
    try {
      await ref.read(userProvider.notifier).getInitialUserData();
      await _initAppUseCase();
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
    } finally {
      await Future.delayed(const Duration(milliseconds: 2000));
      router.go('/home');

      await Future.delayed(const Duration(milliseconds: 650));
      if (hasError) {
        ref
            .read(uiProvider.notifier)
            .showSnackBar(LocaleKeys.errors_exceptions_global.tr());
      }
    }
  }
}

final splashProvider = AutoDisposeNotifierProvider<SplashNotifier, void>(
  SplashNotifier.new,
);
