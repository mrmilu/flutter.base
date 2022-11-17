class AppError implements Exception {
  final String? message;
  final AppErrorCode? code;

  const AppError({
    this.message,
    this.code,
  });

  @override
  String toString() {
    return '${code.toString()} - $message';
  }
}

enum AppErrorCode {
  appleAuthCanceled,
  badRequest,
  forbidden,
  internalServer,
  generalError,
  googleAuthCanceled,
  notFound,
  resendEmailDoesNotExist,
  socialLoginError,
  unauthorized,
  wrongCredentials,
}
