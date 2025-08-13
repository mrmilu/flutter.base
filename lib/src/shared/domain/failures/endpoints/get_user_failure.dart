import 'package:freezed_annotation/freezed_annotation.dart';

import 'general_base_failure.dart';

part 'get_user_failure.freezed.dart';

@freezed
abstract class GetUserFailure with _$GetUserFailure {
  const factory GetUserFailure.userNotFound({
    @Default('userNotFound') String code,
    @Default('Usuario no encontrado.') String msg,
  }) = GetUserFailureUserNotFound;

  const factory GetUserFailure.userInvalid({
    @Default('userInvalid') String code,
    @Default('Usuario inválido.') String msg,
  }) = GetUserFailureUserInvalid;

  const factory GetUserFailure.general(GeneralBaseFailure error) =
      GetUserFailureGeneral;

  const GetUserFailure._();

  String get message => when(
    userNotFound: (code, msg) => msg,
    userInvalid: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    userNotFound: (code, msg) =>
        GetUserFailure.userNotFound(code: code, msg: msg),
    userInvalid: (code, msg) =>
        GetUserFailure.userInvalid(code: code, msg: msg),
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static GetUserFailure fromString(String code, [String? message]) {
    return switch (code) {
      'userNotFound' => GetUserFailure.userNotFound(
        msg: message ?? 'Usuario no encontrado.',
      ),
      'userInvalid' => GetUserFailure.userInvalid(
        msg: message ?? 'Usuario inválido.',
      ),
      _ => GetUserFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
