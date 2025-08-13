import 'package:flutter_base/src/shared/domain/failures/endpoints/download_file_failure.dart';
import 'package:flutter_base/src/shared/domain/failures/endpoints/general_base_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DownloadFileFailure Tests', () {
    group('Get Message', () {
      test('should return correct message for problemWithSaveFile', () {
        final failure = const DownloadFileFailure.problemWithSaveFile();
        expect(failure.message, 'Problema al guardar el archivo.');
      });

      test('should return correct message for notFound', () {
        final failure = const DownloadFileFailure.notFound();
        expect(failure.message, 'Archivo no encontrado.');
      });

      test('should return correct message for noPermission', () {
        final failure = const DownloadFileFailure.noPermission();
        expect(
          failure.message,
          'No tienes permiso para descargar este archivo.',
        );
      });

      test('should return message from GeneralBaseFailure', () {
        final generalFailure = const GeneralBaseFailure.networkError();
        final failure = DownloadFileFailure.general(generalFailure);
        expect(failure.message, generalFailure.message);
      });
    });

    group('Get TypeError', () {
      test('should return correct typeError for problemWithSaveFile', () {
        final failure = const DownloadFileFailure.problemWithSaveFile();
        expect(
          failure.typeError,
          isA<DownloadFileFailureProblemWithSaveFile>(),
        );
      });

      test('should return correct typeError for notFound', () {
        final failure = const DownloadFileFailure.notFound();
        expect(
          failure.typeError,
          isA<DownloadFileFailureNotFound>(),
        );
      });

      test('should return correct typeError for noPermission', () {
        final failure = const DownloadFileFailure.noPermission();
        expect(
          failure.typeError,
          isA<DownloadFileFailureNoPermission>(),
        );
      });

      test('should return GeneralBaseFailure for unknown error', () {
        final failure = DownloadFileFailure.fromString('unknown');
        expect(failure.typeError, isA<GeneralBaseFailure>());
      });
    });

    group('FromString', () {
      test('should return problemWithSaveFile failure from string', () {
        final failure = DownloadFileFailure.fromString(
          'problemWithSaveFile',
        );
        expect(
          failure.typeError,
          isA<DownloadFileFailureProblemWithSaveFile>(),
        );
      });

      test('should return notFound failure from string', () {
        final failure = DownloadFileFailure.fromString(
          'notFound',
        );
        expect(
          failure.typeError,
          isA<DownloadFileFailureNotFound>(),
        );
      });

      test('should return noPermission failure from string', () {
        final failure = DownloadFileFailure.fromString(
          'noPermission',
        );
        expect(
          failure.typeError,
          isA<DownloadFileFailureNoPermission>(),
        );
      });

      test('should return internalError failure from string', () {
        final failure = DownloadFileFailure.fromString(
          'internalError',
        );
        expect(
          failure.typeError,
          isA<GeneralBaseFailureInternalError>(),
        );
      });

      test('should return GeneralBaseFailure for unknown error code', () {
        final failure = DownloadFileFailure.fromString('unknown');
        expect(failure.typeError, isA<GeneralBaseFailure>());
      });
    });
  });
}
