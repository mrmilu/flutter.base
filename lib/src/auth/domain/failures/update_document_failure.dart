import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/failures/endpoints/general_base_failure.dart';

part 'update_document_failure.freezed.dart';

@freezed
abstract class UpdateDocumentFailure with _$UpdateDocumentFailure {
  const factory UpdateDocumentFailure.noSupported({
    @Default('noSupported') String code,
    @Default('No soportado.') String msg,
  }) = UpdateDocumentFailureNoSupported;

  const factory UpdateDocumentFailure.general(GeneralBaseFailure error) =
      UpdateDocumentFailureGeneral;

  const UpdateDocumentFailure._();

  String get message => when(
    noSupported: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    noSupported: (code, msg) =>
        UpdateDocumentFailure.noSupported(code: code, msg: msg),
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static UpdateDocumentFailure fromString(String code, [String? message]) {
    return switch (code) {
      'noSupported' => UpdateDocumentFailure.noSupported(
        msg: message ?? 'No soportado.',
      ),
      _ => UpdateDocumentFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
