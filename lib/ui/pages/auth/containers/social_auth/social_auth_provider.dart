import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/core/auth/domain/models/auth_provider.dart';
import 'package:flutter_base/core/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_base/core/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SocialAuthProvider {
  late UserProvider _userProvider;
  late UiProvider _uiProvider;
  final _loginUseCase = GetIt.I.get<LoginUseCase>();
  final _signUpUseCase = GetIt.I.get<SignUpUseCase>();
  final _appRouter = GetIt.I.get<GoRouter>();

  SocialAuthProvider(AutoDisposeProviderRef ref) {
    _userProvider = ref.read(userProvider.notifier);
    _uiProvider = ref.read(uiProvider.notifier);
  }

  void socialLogin(AuthProvider provider) async {
    _uiProvider.showGlobalLoader();
    try {
      final input = LoginUseCaseInput(provider: provider);
      final user = await _loginUseCase(input);
      _userProvider.setUserData(user.toViewModel());
      _appRouter.go("/home");
    } on AppError catch (e, stackTrace) {
      if (e.code != AppErrorCode.appleAuthCanceled &&
          e.code != AppErrorCode.googleAuthCanceled &&
          (e.code != AppErrorCode.badRequest &&
              e.code != AppErrorCode.wrongCredentials)) {
        _uiProvider.showSnackBar(LocaleKeys.errorsMessages_global.tr());
        Sentry.captureException(e, stackTrace: stackTrace);
      } else if (e.code == AppErrorCode.badRequest ||
          e.code == AppErrorCode.wrongCredentials) {
        _uiProvider
            .showSnackBar(e.message ?? LocaleKeys.errorsMessages_global.tr());
      }
    } finally {
      _uiProvider.hideGlobalLoader();
    }
  }

  void socialSignUp(AuthProvider provider) async {
    _uiProvider.showGlobalLoader();
    try {
      final input = SignUpUseCaseInput(provider: provider);
      final user = await _signUpUseCase(input);
      _userProvider.setUserData(user.toViewModel());
      _appRouter.go("/home");
    } on AppError catch (e) {
      if (e.code != AppErrorCode.appleAuthCanceled &&
          e.code != AppErrorCode.googleAuthCanceled &&
          e.code != AppErrorCode.badRequest) {
        _uiProvider.showSnackBar(LocaleKeys.errorsMessages_global.tr());
      } else if (e.code == AppErrorCode.badRequest) {
        _uiProvider
            .showSnackBar(e.message ?? LocaleKeys.errorsMessages_global.tr());
      }
    } finally {
      _uiProvider.hideGlobalLoader();
    }
  }
}

final socialAuthProvider =
    AutoDisposeProvider<SocialAuthProvider>((ref) => SocialAuthProvider(ref));
