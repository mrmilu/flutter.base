import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/core/auth/domain/enums/auth_provider.dart';
import 'package:flutter_base/core/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_base/core/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/utils/platform.dart';
import 'package:flutter_base/ui/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SocialAuthProvider extends AutoDisposeNotifier {
  final _loginUseCase = GetIt.I.get<LoginUseCase>();
  final _signUpUseCase = GetIt.I.get<SignUpUseCase>();
  final _appRouter = GetIt.I.get<GoRouter>();

  @override
  void build() {}

  void socialLogin(SocialAuthServiceProvider provider) async {
    final uiNotifier = ref.read(uiProvider.notifier);
    final userNotifier = ref.read(userProvider.notifier);
    uiNotifier.showGlobalLoader();
    try {
      if (deviceType == null) {
        throw const AppError(code: AppErrorCode.errorRetrievingDeviceToken);
      }
      final input = LoginUseCaseInput(
        provider: provider,
        userDeviceType: deviceType!,
      );
      final user = await _loginUseCase(input);
      userNotifier.setUserData(user.toViewModel());
      _appRouter.go('/home');
    } on AppError catch (e, stackTrace) {
      if (e.code != AppErrorCode.appleAuthCanceled &&
          e.code != AppErrorCode.googleAuthCanceled &&
          (e.code != AppErrorCode.badRequest &&
              e.code != AppErrorCode.wrongCredentials)) {
        uiNotifier.showSnackBar(LocaleKeys.errors_exceptions_global.tr());
        Sentry.captureException(e, stackTrace: stackTrace);
      } else if (e.code == AppErrorCode.badRequest ||
          e.code == AppErrorCode.wrongCredentials) {
        uiNotifier.showSnackBar(
          e.message ?? LocaleKeys.errors_exceptions_global.tr(),
        );
      }
    } finally {
      uiNotifier.hideGlobalLoader();
    }
  }

  void socialSignUp(SocialAuthServiceProvider provider) async {
    final uiNotifier = ref.read(uiProvider.notifier);
    final userNotifier = ref.read(userProvider.notifier);
    uiNotifier.showGlobalLoader();
    try {
      final input = SignUpUseCaseInput(socialAuthProvider: provider);
      final user = await _signUpUseCase(input);
      userNotifier.setUserData(user.toViewModel());
      _appRouter.go('/home');
    } on AppError catch (e) {
      if (e.code != AppErrorCode.appleAuthCanceled &&
          e.code != AppErrorCode.googleAuthCanceled &&
          e.code != AppErrorCode.badRequest) {
        uiNotifier.showSnackBar(LocaleKeys.errors_exceptions_global.tr());
      } else if (e.code == AppErrorCode.badRequest) {
        uiNotifier.showSnackBar(
          e.message ?? LocaleKeys.errors_exceptions_global.tr(),
        );
      }
    } finally {
      uiNotifier.hideGlobalLoader();
    }
  }
}

final socialAuthProvider =
    AutoDisposeNotifierProvider<SocialAuthProvider, void>(
  SocialAuthProvider.new,
);
