import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/failures/endpoints/general_base_failure.dart';

part 'change_password_failure.freezed.dart';

@freezed
abstract class ChangePasswordFailure with _$ChangePasswordFailure {
  const factory ChangePasswordFailure.weakPassword({
    @Default('weakPassword') String code,
    @Default('La contraseña es muy débil.') String msg,
  }) = ChangePasswordFailureWeakPassword;

  const factory ChangePasswordFailure.general(GeneralBaseFailure error) =
      ChangePasswordFailureGeneral;

  const ChangePasswordFailure._();

  String get message => when(
    weakPassword: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    weakPassword: (code, msg) =>
        ChangePasswordFailure.weakPassword(code: code, msg: msg),
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static ChangePasswordFailure fromString(String code, [String? message]) {
    return switch (code) {
      'weakPassword' => ChangePasswordFailure.weakPassword(
        msg: message ?? 'La contraseña es muy débil.',
      ),
      _ => ChangePasswordFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
