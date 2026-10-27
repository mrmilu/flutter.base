import 'package:flutter_jungle_core/flutter_jungle_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_user_info_failure.freezed.dart';

@freezed
abstract class ChangeUserInfoFailure with _$ChangeUserInfoFailure {
  const factory ChangeUserInfoFailure.invalidName({
    @Default('invalidName') String code,
    @Default('Nombre inválido.') String msg,
  }) = ChangeUserInfoFailureInvalidName;

  const factory ChangeUserInfoFailure.invalidSurname({
    @Default('invalidSurname') String code,
    @Default('Apellido inválido.') String msg,
  }) = ChangeUserInfoFailureInvalidSurname;

  const factory ChangeUserInfoFailure.general(
    GeneralBaseFailure error,
  ) = ChangeUserInfoFailureGeneral;

  const ChangeUserInfoFailure._();

  String get message => when(
    invalidName: (code, msg) => msg,
    invalidSurname: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    invalidName: (code, msg) =>
        ChangeUserInfoFailure.invalidName(code: code, msg: msg),
    invalidSurname: (code, msg) =>
        ChangeUserInfoFailure.invalidSurname(code: code, msg: msg),
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static ChangeUserInfoFailure fromString(
    String code, [
    String? message,
  ]) {
    return switch (code) {
      'invalidName' => ChangeUserInfoFailure.invalidName(
        msg: message ?? 'Nombre inválido.',
      ),
      'invalidSurname' => ChangeUserInfoFailure.invalidSurname(
        msg: message ?? 'Apellido inválido.',
      ),
      _ => ChangeUserInfoFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
