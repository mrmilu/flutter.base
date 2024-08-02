import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/auth/domain/enums/auth_provider.dart';
import 'package:flutter_base/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_base/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/core/app/domain/models/device_type.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/user/domain/enums/user_device_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SocialAuthNotifier extends AutoDisposeNotifier {
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
      final deviceType = DeviceType.deviceType;
      if (deviceType == UserDeviceType.unknown) {
        throw const AppError(code: AppErrorCode.errorRetrievingDeviceToken);
      }
      final input = LoginUseCaseInput(
        provider: provider,
        userDeviceType: deviceType,
      );
      final user = await _loginUseCase(input);
      userNotifier.setUserData(user);
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
      userNotifier.setUserData(user);
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
    AutoDisposeNotifierProvider<SocialAuthNotifier, void>(
  SocialAuthNotifier.new,
);
