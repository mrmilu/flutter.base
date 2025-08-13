import 'package:flutter_base/src/shared/domain/failures/general_base_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeneralBaseFailure', () {
    test('should create Unauthorized with default message', () {
      const error = GeneralBaseFailure.unauthorized();
      expect(error.message, 'No estás autorizado. Por favor, inicia sesión.');
    });

    test('should create InternalError with default message', () {
      const error = GeneralBaseFailure.internalError();
      expect(error.message, 'Error interno del servidor. Intenta más tarde.');
    });

    test('should create NetworkError with default message', () {
      const error = GeneralBaseFailure.networkError();
      expect(error.message, 'Sin conexión a internet. Verifica tu red.');
    });

    test('should create TimeoutError with default message', () {
      const error = GeneralBaseFailure.timeoutError();
      expect(error.message, 'La solicitud tardó demasiado. Intenta de nuevo.');
    });

    test('should create InvalidResponseFormat with default message', () {
      const error = GeneralBaseFailure.invalidResponseFormat();
      expect(error.message, 'Formato de respuesta inválido. Contacta soporte.');
    });

    test('should create UnexpectedError with default message', () {
      const error = GeneralBaseFailure.unexpectedError(code: 'test_code');
      expect(error.message, 'Error inesperado. Intenta más tarde.');
    });

    test('should create UnexpectedError with custom message', () {
      const customMessage = 'Custom error';
      const error = GeneralBaseFailure.unexpectedError(
        code: 'test_code',
        message: customMessage,
      );
      expect(error.message, customMessage);
    });

    test('should handle Unauthorized with when', () {
      const error = GeneralBaseFailure.unauthorized();
      final result = error.when(
        unauthorized: (code, message) => 'Unauthorized: $message',
        internalError: (code, message) => 'Internal: $message',
        networkError: (code, message) => 'Network: $message',
        timeoutError: (code, message) => 'Timeout: $message',
        invalidResponseFormat: (code, message) => 'Invalid: $message',
        unexpectedError: (code, message) => 'Unexpected: $message',
      );
      expect(
        result,
        'Unauthorized: No estás autorizado. Por favor, inicia sesión.',
      );
    });

    test('should handle NetworkError with maybeWhen', () {
      const error = GeneralBaseFailure.networkError();
      final result = error.maybeWhen(
        networkError: (code, message) => 'Network: $message',
        orElse: () => 'Other error',
      );
      expect(result, 'Network: Sin conexión a internet. Verifica tu red.');
    });

    test('should handle UnexpectedError with map', () {
      const error = GeneralBaseFailure.unexpectedError(code: 'test_code');
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
      const error = GeneralBaseFailure.unauthorized();
      final result = error.maybeMap(
        unauthorized: (_) => 'Unauthorized',
        orElse: () => 'Other',
      );
      expect(result, 'Unauthorized');
    });

    test('should support copyWith for UnexpectedError', () {
      const error = GeneralBaseFailure.unexpectedError(code: 'test_code');
      final copied = error.copyWith(message: 'New message');
      expect(copied.message, 'New message');
      expect(copied, isA<GeneralBaseFailureUnexpectedError>());
    });

    test('should support equality for same error type', () {
      const error1 = GeneralBaseFailure.unauthorized();
      const error2 = GeneralBaseFailure.unauthorized();
      expect(error1, equals(error2));
    });

    test('should support toString for NetworkError', () {
      const error = GeneralBaseFailure.networkError();
      expect(error.toString(), contains('networkError'));
      expect(
        error.toString(),
        contains('Sin conexión a internet. Verifica tu red.'),
      );
    });

    // Additional tests for custom messages in all error types
    test('should create Unauthorized with custom message', () {
      const customMessage = 'Custom unauthorized message';
      const error = GeneralBaseFailure.unauthorized(message: customMessage);
      expect(error.message, customMessage);
    });

    test('should create InternalError with custom message', () {
      const customMessage = 'Custom internal error message';
      const error = GeneralBaseFailure.internalError(message: customMessage);
      expect(error.message, customMessage);
    });

    test('should create NetworkError with custom message', () {
      const customMessage = 'Custom network error message';
      const error = GeneralBaseFailure.networkError(message: customMessage);
      expect(error.message, customMessage);
    });

    test('should create TimeoutError with custom message', () {
      const customMessage = 'Custom timeout error message';
      const error = GeneralBaseFailure.timeoutError(message: customMessage);
      expect(error.message, customMessage);
    });

    test('should create InvalidResponseFormat with custom message', () {
      const customMessage = 'Custom invalid response message';
      const error = GeneralBaseFailure.invalidResponseFormat(
        message: customMessage,
      );
      expect(error.message, customMessage);
    });

    // Tests for codeError getter
    test('should return correct code for unauthorized', () {
      const error = GeneralBaseFailure.unauthorized();
      expect(error.code, 'unauthorized');
    });

    test('should return correct code for internalError', () {
      const error = GeneralBaseFailure.internalError();
      expect(error.code, 'internalError');
    });

    test('should return correct code for networkError', () {
      const error = GeneralBaseFailure.networkError();
      expect(error.code, 'networkError');
    });

    test('should return correct code for timeoutError', () {
      const error = GeneralBaseFailure.timeoutError();
      expect(error.code, 'timeoutError');
    });

    test('should return correct code for invalidResponseFormat', () {
      const error = GeneralBaseFailure.invalidResponseFormat();
      expect(error.code, 'invalidResponseFormat');
    });

    test('should return correct code for unexpectedError', () {
      const error = GeneralBaseFailure.unexpectedError(code: 'test_code');
      expect(error.code, 'test_code');
    });

    // Tests for typeError getter
    test('should return correct type for unauthorized', () {
      const error = GeneralBaseFailure.unauthorized();
      final typeError = error.typeError;
      expect(typeError, isA<GeneralBaseFailureUnauthorized>());
      expect(typeError.message, error.message);
    });

    test('should return correct type for internalError', () {
      const error = GeneralBaseFailure.internalError();
      final typeError = error.typeError;
      expect(typeError, isA<GeneralBaseFailureInternalError>());
      expect(typeError.message, error.message);
    });

    test('should return correct type for networkError', () {
      const error = GeneralBaseFailure.networkError();
      final typeError = error.typeError;
      expect(typeError, isA<GeneralBaseFailureNetworkError>());
      expect(typeError.message, error.message);
    });

    test('should return correct type for timeoutError', () {
      const error = GeneralBaseFailure.timeoutError();
      final typeError = error.typeError;
      expect(typeError, isA<GeneralBaseFailureTimeoutError>());
      expect(typeError.message, error.message);
    });

    test('should return correct type for invalidResponseFormat', () {
      const error = GeneralBaseFailure.invalidResponseFormat();
      final typeError = error.typeError;
      expect(typeError, isA<GeneralBaseFailureInvalidResponseFormat>());
      expect(typeError.message, error.message);
    });

    test('should return correct type for unexpectedError', () {
      const error = GeneralBaseFailure.unexpectedError(code: 'test_code');
      final typeError = error.typeError;
      expect(typeError, isA<GeneralBaseFailureUnexpectedError>());
      expect(typeError.message, error.message);
    });

    // Tests for fromString method
    test('should create unauthorized from string with default message', () {
      final error = GeneralBaseFailure.fromString('unauthorized', null);
      expect(error, isA<GeneralBaseFailureUnauthorized>());
      expect(error.message, 'No estás autorizado. Por favor, inicia sesión.');
    });

    test('should create unauthorized from string with custom message', () {
      const customMessage = 'Custom unauthorized';
      final error = GeneralBaseFailure.fromString(
        'unauthorized',
        customMessage,
      );
      expect(error, isA<GeneralBaseFailureUnauthorized>());
      expect(error.message, customMessage);
    });

    test('should create internalError from string with default message', () {
      final error = GeneralBaseFailure.fromString('internalError', null);
      expect(error, isA<GeneralBaseFailureInternalError>());
      expect(error.message, 'Error interno del servidor. Intenta más tarde.');
    });

    test('should create internalError from string with custom message', () {
      const customMessage = 'Custom internal error';
      final error = GeneralBaseFailure.fromString(
        'internalError',
        customMessage,
      );
      expect(error, isA<GeneralBaseFailureInternalError>());
      expect(error.message, customMessage);
    });

    test('should create networkError from string with default message', () {
      final error = GeneralBaseFailure.fromString('networkError', null);
      expect(error, isA<GeneralBaseFailureNetworkError>());
      expect(error.message, 'Sin conexión a internet. Verifica tu red.');
    });

    test('should create networkError from string with custom message', () {
      const customMessage = 'Custom network error';
      final error = GeneralBaseFailure.fromString(
        'networkError',
        customMessage,
      );
      expect(error, isA<GeneralBaseFailureNetworkError>());
      expect(error.message, customMessage);
    });

    test('should create timeoutError from string with default message', () {
      final error = GeneralBaseFailure.fromString('timeoutError', null);
      expect(error, isA<GeneralBaseFailureTimeoutError>());
      expect(error.message, 'La solicitud tardó demasiado. Intenta de nuevo.');
    });

    test('should create timeoutError from string with custom message', () {
      const customMessage = 'Custom timeout error';
      final error = GeneralBaseFailure.fromString(
        'timeoutError',
        customMessage,
      );
      expect(error, isA<GeneralBaseFailureTimeoutError>());
      expect(error.message, customMessage);
    });

    test(
      'should create invalidResponseFormat from string with default message',
      () {
        final error = GeneralBaseFailure.fromString(
          'invalidResponseFormat',
          null,
        );
        expect(error, isA<GeneralBaseFailureInvalidResponseFormat>());
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
        final error = GeneralBaseFailure.fromString(
          'invalidResponseFormat',
          customMessage,
        );
        expect(error, isA<GeneralBaseFailureInvalidResponseFormat>());
        expect(error.message, customMessage);
      },
    );

    test('should create unexpectedError from string with default message', () {
      final error = GeneralBaseFailure.fromString('unexpectedError', null);
      expect(error, isA<GeneralBaseFailureUnexpectedError>());
      expect(error.message, 'Error inesperado. Intenta más tarde.');
    });

    test('should create unexpectedError from string with custom message', () {
      const customMessage = 'Custom unexpected error';
      final error = GeneralBaseFailure.fromString(
        'unexpectedError',
        customMessage,
      );
      expect(error, isA<GeneralBaseFailureUnexpectedError>());
      expect(error.message, customMessage);
    });

    test(
      'should create unexpectedError for unknown code with default message',
      () {
        final error = GeneralBaseFailure.fromString('unknownCode', null);
        expect(error, isA<GeneralBaseFailureUnexpectedError>());
        expect(error.message, 'Error inesperado. Intenta más tarde.');
      },
    );

    test(
      'should create unexpectedError for unknown code with custom message',
      () {
        const customMessage = 'Custom unknown error';
        final error = GeneralBaseFailure.fromString(
          'unknownCode',
          customMessage,
        );
        expect(error, isA<GeneralBaseFailureUnexpectedError>());
        expect(error.message, customMessage);
      },
    );

    test(
      'should create unexpectedError for empty string with default message',
      () {
        final error = GeneralBaseFailure.fromString('', null);
        expect(error, isA<GeneralBaseFailureUnexpectedError>());
        expect(error.message, 'Error inesperado. Intenta más tarde.');
      },
    );

    // Tests for copyWith on all error types
    test('should support copyWith for Unauthorized', () {
      const error = GeneralBaseFailure.unauthorized();
      final copied = error.copyWith(message: 'New unauthorized message');
      expect(copied.message, 'New unauthorized message');
      expect(copied, isA<GeneralBaseFailureUnauthorized>());
    });

    test('should support copyWith for InternalError', () {
      const error = GeneralBaseFailure.internalError();
      final copied = error.copyWith(message: 'New internal error message');
      expect(copied.message, 'New internal error message');
      expect(copied, isA<GeneralBaseFailureInternalError>());
    });

    test('should support copyWith for NetworkError', () {
      const error = GeneralBaseFailure.networkError();
      final copied = error.copyWith(message: 'New network error message');
      expect(copied.message, 'New network error message');
      expect(copied, isA<GeneralBaseFailureNetworkError>());
    });

    test('should support copyWith for TimeoutError', () {
      const error = GeneralBaseFailure.timeoutError();
      final copied = error.copyWith(message: 'New timeout error message');
      expect(copied.message, 'New timeout error message');
      expect(copied, isA<GeneralBaseFailureTimeoutError>());
    });

    test('should support copyWith for InvalidResponseFormat', () {
      const error = GeneralBaseFailure.invalidResponseFormat();
      final copied = error.copyWith(message: 'New invalid format message');
      expect(copied.message, 'New invalid format message');
      expect(copied, isA<GeneralBaseFailureInvalidResponseFormat>());
    });

    // Additional equality tests
    test('should support equality for different error types', () {
      const error1 = GeneralBaseFailure.unauthorized();
      const error2 = GeneralBaseFailure.networkError();
      expect(error1, isNot(equals(error2)));
    });

    test(
      'should support equality for same error type with different messages',
      () {
        const error1 = GeneralBaseFailure.unauthorized();
        const error2 = GeneralBaseFailure.unauthorized(
          message: 'Different message',
        );
        expect(error1, isNot(equals(error2)));
      },
    );

    test(
      'should support equality for same error type with same custom message',
      () {
        const customMessage = 'Same custom message';
        const error1 = GeneralBaseFailure.unauthorized(message: customMessage);
        const error2 = GeneralBaseFailure.unauthorized(message: customMessage);
        expect(error1, equals(error2));
      },
    );

    // Additional toString tests
    test('should support toString for all error types', () {
      const errors = [
        GeneralBaseFailure.unauthorized(),
        GeneralBaseFailure.internalError(),
        GeneralBaseFailure.timeoutError(),
        GeneralBaseFailure.invalidResponseFormat(),
        GeneralBaseFailure.unexpectedError(code: 'test_code'),
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
      const error = GeneralBaseFailure.networkError(message: customMessage);
      final typeError = error.typeError;
      expect(typeError, isA<GeneralBaseFailureNetworkError>());
      expect(typeError.message, customMessage);
    });

    test('should maintain immutability with copyWith', () {
      const originalMessage = 'Original message';
      const newMessage = 'New message';
      const original = GeneralBaseFailure.unauthorized(
        message: originalMessage,
      );
      final copied = original.copyWith(message: newMessage);

      expect(original.message, originalMessage);
      expect(copied.message, newMessage);
      expect(original, isNot(same(copied)));
    });

    // Tests for message getter that uses when() internally
    test('should access message getter for Unauthorized', () {
      const error = GeneralBaseFailure.unauthorized();
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'No estás autorizado. Por favor, inicia sesión.');
    });

    test('should access message getter for InternalError', () {
      const error = GeneralBaseFailure.internalError();
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'Error interno del servidor. Intenta más tarde.');
    });

    test('should access message getter for NetworkError', () {
      const error = GeneralBaseFailure.networkError();
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'Sin conexión a internet. Verifica tu red.');
    });

    test('should access message getter for TimeoutError', () {
      const error = GeneralBaseFailure.timeoutError();
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'La solicitud tardó demasiado. Intenta de nuevo.');
    });

    test('should access message getter for InvalidResponseFormat', () {
      const error = GeneralBaseFailure.invalidResponseFormat();
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'Formato de respuesta inválido. Contacta soporte.');
    });

    test('should access message getter for UnexpectedError', () {
      const error = GeneralBaseFailure.unexpectedError(code: 'test_code');
      // This specifically tests the getter that uses when() internally
      final message = error.message;
      expect(message, 'Error inesperado. Intenta más tarde.');
    });

    // Tests for message getter with custom messages
    test(
      'should access message getter for Unauthorized with custom message',
      () {
        const customMessage = 'Custom unauthorized message';
        const error = GeneralBaseFailure.unauthorized(message: customMessage);
        final message = error.message;
        expect(message, customMessage);
      },
    );

    test(
      'should access message getter for NetworkError with custom message',
      () {
        const customMessage = 'Custom network message';
        const error = GeneralBaseFailure.networkError(message: customMessage);
        final message = error.message;
        expect(message, customMessage);
      },
    );
  });
}
