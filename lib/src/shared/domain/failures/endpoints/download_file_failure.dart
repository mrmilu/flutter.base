import 'package:freezed_annotation/freezed_annotation.dart';

import 'general_base_failure.dart';

part 'download_file_failure.freezed.dart';

@freezed
abstract class DownloadFileFailure with _$DownloadFileFailure {
  const factory DownloadFileFailure.problemWithSaveFile({
    @Default('problemWithSaveFile') String code,
    @Default('Problema al guardar el archivo.') String msg,
  }) = DownloadFileFailureProblemWithSaveFile;

  const factory DownloadFileFailure.notFound({
    @Default('notFound') String code,
    @Default('Archivo no encontrado.') String msg,
  }) = DownloadFileFailureNotFound;

  const factory DownloadFileFailure.noPermission({
    @Default('noPermission') String code,
    @Default('No tienes permiso para descargar este archivo.') String msg,
  }) = DownloadFileFailureNoPermission;

  const factory DownloadFileFailure.general(
    GeneralBaseFailure error,
  ) = DownloadFileFailureGeneral;

  const DownloadFileFailure._();

  String get message => when(
    problemWithSaveFile: (code, msg) => msg,
    notFound: (code, msg) => msg,
    noPermission: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    problemWithSaveFile: (code, msg) =>
        DownloadFileFailure.problemWithSaveFile(code: code, msg: msg),
    notFound: (code, msg) => DownloadFileFailure.notFound(code: code, msg: msg),
    noPermission: (code, msg) =>
        DownloadFileFailure.noPermission(code: code, msg: msg),
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static DownloadFileFailure fromString(
    String code, [
    String? message,
  ]) {
    return switch (code) {
      'problemWithSaveFile' => DownloadFileFailure.problemWithSaveFile(
        msg: message ?? 'Problema al guardar el archivo.',
      ),
      'notFound' => DownloadFileFailure.notFound(
        msg: message ?? 'Archivo no encontrado.',
      ),
      'noPermission' => DownloadFileFailure.noPermission(
        msg: message ?? 'No tienes permiso para descargar este archivo.',
      ),
      _ => DownloadFileFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
