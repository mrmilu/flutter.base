import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/failures/endpoints/general_base_failure.dart';

part 'signin_failure.freezed.dart';

@freezed
abstract class SigninFailure with _$SigninFailure {
  const factory SigninFailure.notExistEmail({
    @Default('notExistEmail') String code,
    @Default('No existe el correo electrónico.') String msg,
  }) = SigninFailureNotExistEmail;

  const factory SigninFailure.general(GeneralBaseFailure error) =
      SigninFailureGeneral;

  const SigninFailure._();

  String get message => when(
    notExistEmail: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    notExistEmail: (code, msg) =>
        SigninFailure.notExistEmail(code: code, msg: msg),
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static SigninFailure fromString(String code, [String? message]) {
    return switch (code) {
      'notExistEmail' => SigninFailure.notExistEmail(
        msg: message ?? 'No existe el correo electrónico.',
      ),
      _ => SigninFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
