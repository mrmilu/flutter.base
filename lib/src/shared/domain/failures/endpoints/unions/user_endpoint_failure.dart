import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_error.dart';

part 'user_endpoint_failure.freezed.dart';

@freezed
class UserEndpointError with _$UserEndpointError {
  const factory UserEndpointError.userNotFound({
    @Default('Usuario no encontrado.') String message,
  }) = UserNotFound;

  const factory UserEndpointError.userInvalid({
    @Default('Usuario inválido.') String message,
  }) = UserInvalid;

  const factory UserEndpointError.general(AppBaseError error) = GeneralError;

  const UserEndpointError._();

  String get message => when(
    userNotFound: (message) => message,
    userInvalid: (message) => message,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    userNotFound: (message) => UserNotFound(message: message),
    userInvalid: (message) => UserInvalid(message: message),
    general: (appError) =>
        AppBaseError.fromString(appError.codeError, appError.message),
  );

  static UserEndpointError fromString(String code, [String? message]) {
    switch (code) {
      case 'userNotFound':
        return UserEndpointError.userNotFound(
          message: message ?? 'Usuario no encontrado.',
        );
      case 'userInvalid':
        return UserEndpointError.userInvalid(
          message: message ?? 'Usuario inválido.',
        );
      default:
        return UserEndpointError.general(
          AppBaseError.fromString(code, message),
        );
    }
  }
}
