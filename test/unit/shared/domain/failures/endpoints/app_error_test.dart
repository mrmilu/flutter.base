import 'package:flutter_base/src/shared/domain/failures/endpoints/unions/app_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppBaseError', () {
    test('should create Unauthorized with default message', () {
      const error = AppBaseError.unauthorized();
      expect(error.message, 'No estás autorizado. Por favor, inicia sesión.');
    });

    test('should create InternalError with default message', () {
      const error = AppBaseError.internalError();
      expect(error.message, 'Error interno del servidor. Intenta más tarde.');
    });

    test('should create NetworkError with default message', () {
      const error = AppBaseError.networkError();
      expect(error.message, 'Sin conexión a internet. Verifica tu red.');
    });

    test('should create TimeoutError with default message', () {
      const error = AppBaseError.timeoutError();
      expect(error.message, 'La solicitud tardó demasiado. Intenta de nuevo.');
    });

    test('should create InvalidResponseFormat with default message', () {
      const error = AppBaseError.invalidResponseFormat();
      expect(error.message, 'Formato de respuesta inválido. Contacta soporte.');
    });

    test('should create UnexpectedError with default message', () {
      const error = AppBaseError.unexpectedError();
      expect(error.message, 'Error inesperado. Intenta más tarde.');
    });

    test('should create UnexpectedError with custom message', () {
      const customMessage = 'Custom error';
      const error = AppBaseError.unexpectedError(message: customMessage);
      expect(error.message, customMessage);
    });

    test('should handle Unauthorized with when', () {
      const error = AppBaseError.unauthorized();
      final result = error.when(
        unauthorized: (message) => 'Unauthorized: $message',
        internalError: (message) => 'Internal: $message',
        networkError: (message) => 'Network: $message',
        timeoutError: (message) => 'Timeout: $message',
        invalidResponseFormat: (message) => 'Invalid: $message',
        unexpectedError: (message) => 'Unexpected: $message',
      );
      expect(
        result,
        'Unauthorized: No estás autorizado. Por favor, inicia sesión.',
      );
    });

    test('should handle NetworkError with maybeWhen', () {
      const error = AppBaseError.networkError();
      final result = error.maybeWhen(
        networkError: (message) => 'Network: $message',
        orElse: () => 'Other error',
      );
      expect(result, 'Network: Sin conexión a internet. Verifica tu red.');
    });

    test('should handle UnexpectedError with map', () {
      const error = AppBaseError.unexpectedError();
      final result = error.map(
        unauthorized: (_) => 'Unauthorized',
        internalError: (_) => 'Internal',
        networkError: (_) => 'Network',
        timeoutError: (_) => 'Timeout',
        invalidResponseFormat: (_) => 'Invalid',
        unexpectedError: (_) => 'Unexpected',
      );
      expect(result, 'Unexpected');
    });

    test('should handle Unauthorized with maybeMap', () {
      const error = AppBaseError.unauthorized();
      final result = error.maybeMap(
        unauthorized: (_) => 'Unauthorized',
        orElse: () => 'Other',
      );
      expect(result, 'Unauthorized');
    });

    test('should support copyWith for UnexpectedError', () {
      const error = AppBaseError.unexpectedError();
      final copied = error.copyWith(message: 'New message');
      expect(copied.message, 'New message');
      expect(copied, isA<UnexpectedError>());
    });

    test('should support equality for same error type', () {
      const error1 = AppBaseError.unauthorized();
      const error2 = AppBaseError.unauthorized();
      expect(error1, equals(error2));
    });

    test('should support toString for NetworkError', () {
      const error = AppBaseError.networkError();
      expect(error.toString(), contains('networkError'));
      expect(
        error.toString(),
        contains('Sin conexión a internet. Verifica tu red.'),
      );
    });

    // Additional tests for custom messages in all error types
    test('should create Unauthorized with custom message', () {
      const customMessage = 'Custom unauthorized message';
      const error = AppBaseError.unauthorized(message: customMessage);
      expect(error.message, customMessage);
    });

    test('should create InternalError with custom message', () {
      const customMessage = 'Custom internal error message';
      const error = AppBaseError.internalError(message: customMessage);
      expect(error.message, customMessage);
    });

    test('should create NetworkError with custom message', () {
      const customMessage = 'Custom network error message';
      const error = AppBaseError.networkError(message: customMessage);
      expect(error.message, customMessage);
    });

    test('should create TimeoutError with custom message', () {
      const customMessage = 'Custom timeout error message';
      const error = AppBaseError.timeoutError(message: customMessage);
      expect(error.message, customMessage);
    });

    test('should create InvalidResponseFormat with custom message', () {
      const customMessage = 'Custom invalid response message';
      const error = AppBaseError.invalidResponseFormat(message: customMessage);
      expect(error.message, customMessage);
    });

    // Tests for codeError getter
    test('should return correct code for unauthorized', () {
      const error = AppBaseError.unauthorized();
      expect(error.codeError, 'unauthorized');
    });

    test('should return correct code for internalError', () {
      const error = AppBaseError.internalError();
      expect(error.codeError, 'internalError');
    });

    test('should return correct code for networkError', () {
      const error = AppBaseError.networkError();
      expect(error.codeError, 'networkError');
    });

    test('should return correct code for timeoutError', () {
      const error = AppBaseError.timeoutError();
      expect(error.codeError, 'timeoutError');
    });

    test('should return correct code for invalidResponseFormat', () {
      const error = AppBaseError.invalidResponseFormat();
      expect(error.codeError, 'invalidResponseFormat');
    });

    test('should return correct code for unexpectedError', () {
      const error = AppBaseError.unexpectedError();
      expect(error.codeError, 'unexpectedError');
    });

    // Tests for typeError getter
    test('should return correct type for unauthorized', () {
      const error = AppBaseError.unauthorized();
      final typeError = error.typeError;
      expect(typeError, isA<Unauthorized>());
      expect(typeError.message, error.message);
    });

    test('should return correct type for internalError', () {
      const error = AppBaseError.internalError();
      final typeError = error.typeError;
      expect(typeError, isA<InternalError>());
      expect(typeError.message, error.message);
    });

    test('should return correct type for networkError', () {
      const error = AppBaseError.networkError();
      final typeError = error.typeError;
      expect(typeError, isA<NetworkError>());
      expect(typeError.message, error.message);
    });

    test('should return correct type for timeoutError', () {
      const error = AppBaseError.timeoutError();
      final typeError = error.typeError;
      expect(typeError, isA<TimeoutError>());
      expect(typeError.message, error.message);
    });

    test('should return correct type for invalidResponseFormat', () {
      const error = AppBaseError.invalidResponseFormat();
      final typeError = error.typeError;
      expect(typeError, isA<InvalidResponseFormat>());
      expect(typeError.message, error.message);
    });

    test('should return correct type for unexpectedError', () {
      const error = AppBaseError.unexpectedError();
      final typeError = error.typeError;
      expect(typeError, isA<UnexpectedError>());
      expect(typeError.message, error.message);
    });

    // Tests for fromString method
    test('should create unauthorized from string with default message', () {
      final error = AppBaseError.fromString('unauthorized', null);
      expect(error, isA<Unauthorized>());
      expect(error.message, 'No estás autorizado. Por favor, inicia sesión.');
    });

    test('should create unauthorized from string with custom message', () {
      const customMessage = 'Custom unauthorized';
      final error = AppBaseError.fromString('unauthorized', customMessage);
      expect(error, isA<Unauthorized>());
      expect(error.message, customMessage);
    });

    test('should create internalError from string with default message', () {
      final error = AppBaseError.fromString('internalError', null);
      expect(error, isA<InternalError>());
      expect(error.message, 'Error interno del servidor. Intenta más tarde.');
    });

    test('should create internalError from string with custom message', () {
      const customMessage = 'Custom internal error';
      final error = AppBaseError.fromString('internalError', customMessage);
      expect(error, isA<InternalError>());
      expect(error.message, customMessage);
    });

    test('should create networkError from string with default message', () {
      final error = AppBaseError.fromString('networkError', null);
      expect(error, isA<NetworkError>());
      expect(error.message, 'Sin conexión a internet. Verifica tu red.');
    });

    test('should create networkError from string with custom message', () {
      const customMessage = 'Custom network error';
      final error = AppBaseError.fromString('networkError', customMessage);
      expect(error, isA<NetworkError>());
      expect(error.message, customMessage);
    });

    test('should create timeoutError from string with default message', () {
      final error = AppBaseError.fromString('timeoutError', null);
      expect(error, isA<TimeoutError>());
      expect(error.message, 'La solicitud tardó demasiado. Intenta de nuevo.');
    });

    test('should create timeoutError from string with custom message', () {
      const customMessage = 'Custom timeout error';
      final error = AppBaseError.fromString('timeoutError', customMessage);
      expect(error, isA<TimeoutError>());
      expect(error.message, customMessage);
    });

    test(
      'should create invalidResponseFormat from string with default message',
      () {
        final error = AppBaseError.fromString('invalidResponseFormat', null);
        expect(error, isA<InvalidResponseFormat>());
        expect(
          error.message,
          'Formato de respuesta inválido. Contacta soporte.',
        );
      },
    );

    test(
      'should create invalidResponseFormat from string with custom message',
      () {
        const customMessage = 'Custom invalid response';
        final error = AppBaseError.fromString(
          'invalidResponseFormat',
          customMessage,
        );
        expect(error, isA<InvalidResponseFormat>());
        expect(error.message, customMessage);
      },
    );

    test('should create unexpectedError from string with default message', () {
      final error = AppBaseError.fromString('unexpectedError', null);
      expect(error, isA<UnexpectedError>());
      expect(error.message, 'Error inesperado. Intenta más tarde.');
    });

    test('should create unexpectedError from string with custom message', () {
      const customMessage = 'Custom unexpected error';
      final error = AppBaseError.fromString('unexpectedError', customMessage);
      expect(error, isA<UnexpectedError>());
      expect(error.message, customMessage);
    });

    test(
      'should create unexpectedError for unknown code with default message',
      () {
        final error = AppBaseError.fromString('unknownCode', null);
        expect(error, isA<UnexpectedError>());
        expect(error.message, 'Error inesperado. Intenta más tarde.');
      },
    );

    test(
      'should create unexpectedError for unknown code with custom message',
      () {
        const customMessage = 'Custom unknown error';
        final error = AppBaseError.fromString('unknownCode', customMessage);
        expect(error, isA<UnexpectedError>());
        expect(error.message, customMessage);
      },
    );

    test(
      'should create unexpectedError for empty string with default message',
      () {
        final error = AppBaseError.fromString('', null);
        expect(error, isA<UnexpectedError>());
        expect(error.message, 'Error inesperado. Intenta más tarde.');
      },
    );

    // Tests for copyWith on all error types
    test('should support copyWith for Unauthorized', () {
      const error = AppBaseError.unauthorized();
      final copied = error.copyWith(message: 'New unauthorized message');
      expect(copied.message, 'New unauthorized message');
      expect(copied, isA<Unauthorized>());
    });

    test('should support copyWith for InternalError', () {
      const error = AppBaseError.internalError();
      final copied = error.copyWith(message: 'New internal error message');
      expect(copied.message, 'New internal error message');
      expect(copied, isA<InternalError>());
    });

    test('should support copyWith for NetworkError', () {
      const error = AppBaseError.networkError();
      final copied = error.copyWith(message: 'New network error message');
      expect(copied.message, 'New network error message');
      expect(copied, isA<NetworkError>());
    });

    test('should support copyWith for TimeoutError', () {
      const error = AppBaseError.timeoutError();
      final copied = error.copyWith(message: 'New timeout error message');
      expect(copied.message, 'New timeout error message');
      expect(copied, isA<TimeoutError>());
    });

    test('should support copyWith for InvalidResponseFormat', () {
      const error = AppBaseError.invalidResponseFormat();
      final copied = error.copyWith(message: 'New invalid format message');
      expect(copied.message, 'New invalid format message');
      expect(copied, isA<InvalidResponseFormat>());
    });

    // Additional equality tests
    test('should support equality for different error types', () {
      const error1 = AppBaseError.unauthorized();
      const error2 = AppBaseError.networkError();
      expect(error1, isNot(equals(error2)));
    });

    test(
      'should support equality for same error type with different messages',
      () {
        const error1 = AppBaseError.unauthorized();
        const error2 = AppBaseError.unauthorized(message: 'Different message');
        expect(error1, isNot(equals(error2)));
      },
    );

    test(
      'should support equality for same error type with same custom message',
      () {
        const customMessage = 'Same custom message';
        const error1 = AppBaseError.unauthorized(message: customMessage);
        const error2 = AppBaseError.unauthorized(message: customMessage);
        expect(error1, equals(error2));
      },
    );

    // Additional toString tests
    test('should support toString for all error types', () {
      const errors = [
        AppBaseError.unauthorized(),
        AppBaseError.internalError(),
        AppBaseError.timeoutError(),
        AppBaseError.invalidResponseFormat(),
        AppBaseError.unexpectedError(),
      ];

      for (final error in errors) {
        final toString = error.toString();
        expect(toString, isA<String>());
        expect(toString.isNotEmpty, true);
        expect(toString, contains(error.message));
      }
    });

    // Edge case tests
    test('should handle typeError with custom message', () {
      const customMessage = 'Custom error message';
      const error = AppBaseError.networkError(message: customMessage);
      final typeError = error.typeError;
      expect(typeError, isA<NetworkError>());
      expect(typeError.message, customMessage);
    });

    test('should maintain immutability with copyWith', () {
      const originalMessage = 'Original message';
      const newMessage = 'New message';
      const original = AppBaseError.unauthorized(message: originalMessage);
      final copied = original.copyWith(message: newMessage);

      expect(original.message, originalMessage);
      expect(copied.message, newMessage);
      expect(original, isNot(same(copied)));
    });

    // Tests for message getter that uses when() internally
    test('should access message getter for Unauthorized', () {
      const error = AppBaseError.unauthorized();
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'No estás autorizado. Por favor, inicia sesión.');
    });

    test('should access message getter for InternalError', () {
      const error = AppBaseError.internalError();
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'Error interno del servidor. Intenta más tarde.');
    });

    test('should access message getter for NetworkError', () {
      const error = AppBaseError.networkError();
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'Sin conexión a internet. Verifica tu red.');
    });

    test('should access message getter for TimeoutError', () {
      const error = AppBaseError.timeoutError();
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'La solicitud tardó demasiado. Intenta de nuevo.');
    });

    test('should access message getter for InvalidResponseFormat', () {
      const error = AppBaseError.invalidResponseFormat();
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'Formato de respuesta inválido. Contacta soporte.');
    });

    test('should access message getter for UnexpectedError', () {
      const error = AppBaseError.unexpectedError();
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'Error inesperado. Intenta más tarde.');
    });

    // Tests for message getter with custom messages
    test(
      'should access message getter for Unauthorized with custom message',
      () {
        const customMessage = 'Custom unauthorized message';
        const error = AppBaseError.unauthorized(message: customMessage);
        final message = error.message;
        expect(message, customMessage);
      },
    );

    test(
      'should access message getter for NetworkError with custom message',
      () {
        const customMessage = 'Custom network message';
        const error = AppBaseError.networkError(message: customMessage);
        final message = error.message;
        expect(message, customMessage);
      },
    );
  });
}
