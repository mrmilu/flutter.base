import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/failures/endpoints/general_base_failure.dart';

part 'change_language_failure.freezed.dart';

@freezed
abstract class ChangeLanguageFailure with _$ChangeLanguageFailure {
  const factory ChangeLanguageFailure.general(GeneralBaseFailure error) =
      ChangeLanguageFailureGeneral;

  const ChangeLanguageFailure._();

  String get message => when(
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static ChangeLanguageFailure fromString(String code, [String? message]) {
    return switch (code) {
      _ => ChangeLanguageFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
