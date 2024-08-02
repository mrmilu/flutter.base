import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/src/shared/domain/models/app_error.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';

extension AppErrorCodeMessages on AppErrorCode {
  String getMessage() {
    switch (this) {
      case AppErrorCode.appleAuthCanceled:
        return LocaleKeys.errors_exceptions_apple_auth_cancel.tr();
      case AppErrorCode.badRequest:
        return LocaleKeys.errors_exceptions_bad_request.tr();
      case AppErrorCode.generalError:
        return LocaleKeys.errors_exceptions_global.tr();
      case AppErrorCode.googleAuthCanceled:
        return LocaleKeys.errors_exceptions_google_auth_cancel.tr();
      case AppErrorCode.resendEmailDoesNotExist:
        return LocaleKeys.errors_exceptions_email_does_not_exist.tr();
      case AppErrorCode.socialLoginError:
        return LocaleKeys.errors_exceptions_social_login_error.tr();
      case AppErrorCode.unauthorized:
        return LocaleKeys.errors_exceptions_unauthorized.tr();
      case AppErrorCode.wrongCredentials:
        return LocaleKeys.errors_exceptions_wrong_credentials.tr();
      case AppErrorCode.forbidden:
        return LocaleKeys.errors_exceptions_wrong_credentials.tr();
      case AppErrorCode.notFound:
        return LocaleKeys.errors_exceptions_wrong_credentials.tr();
      case AppErrorCode.internalServer:
        return LocaleKeys.errors_exceptions_wrong_credentials.tr();
      default:
        return '';
    }
  }
}
