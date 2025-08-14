import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/failures/endpoints/general_base_failure.dart';

part 'signup_failure.freezed.dart';

@freezed
abstract class SignupFailure with _$SignupFailure {
  const factory SignupFailure.emailAlreadyExist({
    @Default('emailAlreadyExist') String code,
    @Default('El correo electrónico ya existe.') String msg,
  }) = SignupFailureEmailAlreadyExist;

  const factory SignupFailure.weakPassword({
    @Default('weakPassword') String code,
    @Default('La contraseña es muy débil.') String msg,
  }) = SignupFailureWeakPassword;

  const factory SignupFailure.general(GeneralBaseFailure error) =
      SignupFailureGeneral;

  const SignupFailure._();

  String get message => when(
    emailAlreadyExist: (code, msg) => msg,
    weakPassword: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    emailAlreadyExist: (code, msg) =>
        SignupFailure.emailAlreadyExist(code: code, msg: msg),
    weakPassword: (code, msg) =>
        SignupFailure.weakPassword(code: code, msg: msg),
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static SignupFailure fromString(String code, [String? message]) {
    return switch (code) {
      'emailAlreadyExist' => SignupFailure.emailAlreadyExist(
        msg: message ?? 'El correo electrónico ya existe.',
      ),
      'weakPassword' => SignupFailure.weakPassword(
        msg: message ?? 'La contraseña es muy débil.',
      ),
      _ => SignupFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
