import 'package:flutter_base/src/shared/domain/failures/firebase_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirebaseFailure', () {
    group('Factory constructors', () {
      test('Debería crear FirebaseFailureServerError correctamente', () {
        // Act
        final failure = FirebaseFailure.serverError();

        // Assert
        expect(failure, isA<FirebaseFailureServerError>());
        expect(failure.runtimeType, equals(FirebaseFailureServerError));
      });
    });

    group('when method', () {
      test(
        'Debería ejecutar callback serverError para FirebaseFailureServerError',
        () {
          // Arrange
          final failure = FirebaseFailure.serverError();
          var serverErrorCallbackExecuted = false;

          // Act
          failure.when(
            serverError: (failure) => serverErrorCallbackExecuted = true,
          );

          // Assert
          expect(serverErrorCallbackExecuted, isTrue);
        },
      );

      test('Debería pasar la instancia correcta al callback', () {
        // Arrange
        final serverErrorFailure = FirebaseFailure.serverError();
        FirebaseFailure? receivedServerError;

        // Act
        serverErrorFailure.when(
          serverError: (failure) => receivedServerError = failure,
        );

        // Assert
        expect(receivedServerError, isA<FirebaseFailureServerError>());
        expect(receivedServerError, equals(serverErrorFailure));
      });
    });

    group('map method', () {
      test('Debería mapear FirebaseFailureServerError correctamente', () {
        // Arrange
        final failure = FirebaseFailure.serverError();

        // Act
        final result = failure.map<String>(
          serverError: (failure) => 'server_error',
        );

        // Assert
        expect(result, equals('server_error'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        final serverErrorFailure = FirebaseFailure.serverError();

        // Act
        final intResult = serverErrorFailure.map<int>(
          serverError: (failure) => 500,
        );

        final boolResult = serverErrorFailure.map<bool>(
          serverError: (failure) => true,
        );

        // Assert
        expect(intResult, equals(500));
        expect(boolResult, equals(true));
      });
    });

    group('maybeWhen method', () {
      test('Debería ejecutar callback específico cuando está presente', () {
        // Arrange
        final failure = FirebaseFailure.serverError();
        var serverErrorExecuted = false;
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          serverError: (failure) => serverErrorExecuted = true,
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(serverErrorExecuted, isTrue);
        expect(orElseExecuted, isFalse);
      });

      test('Debería ejecutar orElse cuando callback específico es null', () {
        // Arrange
        final failure = FirebaseFailure.serverError();
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(orElseExecuted, isTrue);
      });
    });

    group('toString method', () {
      test(
        'Debería devolver "serverError" para FirebaseFailureServerError',
        () {
          // Arrange
          final failure = FirebaseFailure.serverError();

          // Act
          final result = failure.toString();

          // Assert
          expect(result, equals('serverError'));
        },
      );
    });

    group('Type checking', () {
      test('Debería identificar correctamente el tipo', () {
        // Arrange
        final serverError = FirebaseFailure.serverError();

        // Assert
        expect(serverError is FirebaseFailureServerError, isTrue);
      });
    });

    group('Equality and hashCode', () {
      test('Debería considerar iguales instancias del mismo tipo', () {
        // Arrange
        final serverError1 = FirebaseFailure.serverError();
        final serverError2 = FirebaseFailure.serverError();

        // Assert
        expect(serverError1.runtimeType, equals(serverError2.runtimeType));
      });
    });
  });
}
