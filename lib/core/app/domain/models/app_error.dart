class AppError implements Exception {
  final String? message;
  final AppErrorCode? code;

  const AppError({
    this.message,
    this.code,
  });
}

enum AppErrorCode {
  googleAuthCanceled,
  appleAuthCanceled,
  unAuthorized,
  wrongCredentials,
  badRequest,
  generalError,
  resendEmailDoesNotExist,
  socialLoginError,
}
