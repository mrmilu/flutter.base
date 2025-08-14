import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/failures/endpoints/general_base_failure.dart';

part 'validate_email_failure.freezed.dart';

@freezed
abstract class ValidateEmailFailure with _$ValidateEmailFailure {
  const factory ValidateEmailFailure.noSupported({
    @Default('noSupported') String code,
    @Default('No soportado.') String msg,
  }) = ValidateEmailFailureNoSupported;

  const factory ValidateEmailFailure.general(GeneralBaseFailure error) =
      ValidateEmailFailureGeneral;

  const ValidateEmailFailure._();

  String get message => when(
    noSupported: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    noSupported: (code, msg) =>
        ValidateEmailFailure.noSupported(code: code, msg: msg),
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static ValidateEmailFailure fromString(String code, [String? message]) {
    return switch (code) {
      'noSupported' => ValidateEmailFailure.noSupported(
        msg: message ?? 'No soportado.',
      ),
      _ => ValidateEmailFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
