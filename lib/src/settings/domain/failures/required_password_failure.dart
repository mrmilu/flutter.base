import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/failures/endpoints/general_base_failure.dart';

part 'required_password_failure.freezed.dart';

@freezed
abstract class RequiredPasswordFailure with _$RequiredPasswordFailure {
  const factory RequiredPasswordFailure.general(GeneralBaseFailure error) =
      RequiredPasswordFailureGeneral;

  const RequiredPasswordFailure._();

  String get message => when(
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static RequiredPasswordFailure fromString(String code, [String? message]) {
    return switch (code) {
      _ => RequiredPasswordFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
