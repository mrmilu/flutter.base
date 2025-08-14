import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/failures/endpoints/general_base_failure.dart';

part 'oauth_sign_in_failure.freezed.dart';

@freezed
abstract class OAuthSignInFailure with _$OAuthSignInFailure {
  const factory OAuthSignInFailure.accountExistsWithDifferentCredential({
    @Default('accountExistsWithDifferentCredential') String code,
    @Default('La cuenta ya existe con credenciales diferentes.') String msg,
  }) = OAuthSignInFailureAccountExistsWithDifferentCredential;

  const factory OAuthSignInFailure.invalidCredential({
    @Default('invalidCredential') String code,
    @Default('Las credenciales son inválidas.') String msg,
  }) = OAuthSignInFailureInvalidCredential;

  const factory OAuthSignInFailure.cancel({
    @Default('cancel') String code,
    @Default('La operación fue cancelada.') String msg,
  }) = OAuthSignInFailureCancel;

  const factory OAuthSignInFailure.general(GeneralBaseFailure error) =
      OAuthSignInFailureGeneral;

  const OAuthSignInFailure._();

  String get message => when(
    accountExistsWithDifferentCredential: (code, msg) => msg,
    invalidCredential: (code, msg) => msg,
    cancel: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    accountExistsWithDifferentCredential: (code, msg) =>
        OAuthSignInFailure.accountExistsWithDifferentCredential(
          code: code,
          msg: msg,
        ),
    invalidCredential: (code, msg) =>
        OAuthSignInFailure.invalidCredential(code: code, msg: msg),
    cancel: (code, msg) => OAuthSignInFailure.cancel(code: code, msg: msg),
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static OAuthSignInFailure fromString(String code, [String? message]) {
    return switch (code) {
      'accountExistsWithDifferentCredential' =>
        OAuthSignInFailure.accountExistsWithDifferentCredential(
          msg: message ?? 'La cuenta ya existe con credenciales diferentes.',
        ),
      'invalidCredential' => OAuthSignInFailure.invalidCredential(
        msg: message ?? 'Las credenciales son inválidas.',
      ),
      'cancel' => OAuthSignInFailure.cancel(
        msg: message ?? 'La operación fue cancelada.',
      ),
      _ => OAuthSignInFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
