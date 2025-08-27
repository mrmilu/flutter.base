import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/failures/endpoints/general_base_failure.dart';

part 'delete_account_failure.freezed.dart';

@freezed
abstract class DeleteAccountFailure with _$DeleteAccountFailure {
  const factory DeleteAccountFailure.general(GeneralBaseFailure error) =
      DeleteAccountFailureGeneral;

  const DeleteAccountFailure._();

  String get message => when(
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static DeleteAccountFailure fromString(String code, [String? message]) {
    return switch (code) {
      _ => DeleteAccountFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
