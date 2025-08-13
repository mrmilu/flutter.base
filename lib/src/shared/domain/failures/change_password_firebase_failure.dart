import 'package:freezed_annotation/freezed_annotation.dart';

import 'general_base_failure.dart';

part 'change_password_firebase_failure.freezed.dart';

@freezed
abstract class ChangePasswordFirebaseFailure
    with _$ChangePasswordFirebaseFailure {
  const factory ChangePasswordFirebaseFailure.wrongPassword({
    @Default('wrongPassword') String code,
    @Default('Contraseña incorrecta.') String msg,
  }) = ChangePasswordFirebaseFailureWrongPassword;

  const factory ChangePasswordFirebaseFailure.invalidCredential({
    @Default('invalidCredential') String code,
    @Default('Credenciales inválidas.') String msg,
  }) = ChangePasswordFirebaseFailureInvalidCredential;

  const factory ChangePasswordFirebaseFailure.invalidArgument({
    @Default('invalidArgument') String code,
    @Default('Argumento inválido.') String msg,
  }) = ChangePasswordFirebaseFailureInvalidArgument;

  const factory ChangePasswordFirebaseFailure.tooManyRequests({
    @Default('tooManyRequests') String code,
    @Default('Demasiadas solicitudes. Intenta más tarde.') String msg,
  }) = ChangePasswordFirebaseFailureTooManyRequests;

  const factory ChangePasswordFirebaseFailure.general(
    GeneralBaseFailure error,
  ) = ChangePasswordFirebaseFailureGeneral;

  const ChangePasswordFirebaseFailure._();

  String get message => when(
    wrongPassword: (code, msg) => msg,
    invalidCredential: (code, msg) => msg,
    invalidArgument: (code, msg) => msg,
    tooManyRequests: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    wrongPassword: (code, msg) =>
        ChangePasswordFirebaseFailure.wrongPassword(code: code, msg: msg),
    invalidCredential: (code, msg) =>
        ChangePasswordFirebaseFailure.invalidCredential(code: code, msg: msg),
    invalidArgument: (code, msg) =>
        ChangePasswordFirebaseFailure.invalidArgument(code: code, msg: msg),
    tooManyRequests: (code, msg) =>
        ChangePasswordFirebaseFailure.tooManyRequests(code: code, msg: msg),
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static ChangePasswordFirebaseFailure fromString(
    String code, [
    String? message,
  ]) {
    return switch (code) {
      'wrongPassword' => ChangePasswordFirebaseFailure.wrongPassword(
        msg: message ?? 'Contraseña incorrecta.',
      ),
      'invalidCredential' => ChangePasswordFirebaseFailure.invalidCredential(
        msg: message ?? 'Credenciales inválidas.',
      ),
      'invalidArgument' => ChangePasswordFirebaseFailure.invalidArgument(
        msg: message ?? 'Argumento inválido.',
      ),
      'tooManyRequests' => ChangePasswordFirebaseFailure.tooManyRequests(
        msg: message ?? 'Demasiadas solicitudes. Intenta más tarde.',
      ),
      _ => ChangePasswordFirebaseFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
