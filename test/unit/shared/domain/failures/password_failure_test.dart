import 'package:flutter_base/src/shared/domain/failures/password_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PasswordFailure', () {
    group('Factory constructors', () {
      test(
        'Debería crear PasswordFailureInvalidMinLength correctamente con min',
        () {
          // Arrange
          const testMin = 8;

          // Act
          final failure = PasswordFailure.minLength(testMin);

          // Assert
          expect(failure, isA<PasswordFailureInvalidMinLength>());
          expect(failure.runtimeType, equals(PasswordFailureInvalidMinLength));
          expect(
            (failure as PasswordFailureInvalidMinLength).min,
            equals(testMin),
          );
        },
      );

      test('Debería crear PasswordFailureIncludeUppercase correctamente', () {
        // Act
        final failure = PasswordFailure.includeUppercase();

        // Assert
        expect(failure, isA<PasswordFailureIncludeUppercase>());
        expect(failure.runtimeType, equals(PasswordFailureIncludeUppercase));
      });

      test('Debería crear PasswordFailureIncludeLowercase correctamente', () {
        // Act
        final failure = PasswordFailure.includeLowercase();

        // Assert
        expect(failure, isA<PasswordFailureIncludeLowercase>());
        expect(failure.runtimeType, equals(PasswordFailureIncludeLowercase));
      });

      test('Debería crear PasswordFailureIncludeDigit correctamente', () {
        // Act
        final failure = PasswordFailure.includeDigit();

        // Assert
        expect(failure, isA<PasswordFailureIncludeDigit>());
        expect(failure.runtimeType, equals(PasswordFailureIncludeDigit));
      });
    });

    group('when method', () {
      test(
        'Debería ejecutar callback minLength para PasswordFailureInvalidMinLength',
        () {
          // Arrange
          final failure = PasswordFailure.minLength(6);
          var minLengthCallbackExecuted = false;
          var includeUppercaseCallbackExecuted = false;
          var includeLowercaseCallbackExecuted = false;
          var includeDigitCallbackExecuted = false;

          // Act
          failure.when(
            minLength: (failure) => minLengthCallbackExecuted = true,
            includeUppercase: (failure) =>
                includeUppercaseCallbackExecuted = true,
            includeLowercase: (failure) =>
                includeLowercaseCallbackExecuted = true,
            includeDigit: (failure) => includeDigitCallbackExecuted = true,
          );

          // Assert
          expect(minLengthCallbackExecuted, isTrue);
          expect(includeUppercaseCallbackExecuted, isFalse);
          expect(includeLowercaseCallbackExecuted, isFalse);
          expect(includeDigitCallbackExecuted, isFalse);
        },
      );

      test(
        'Debería ejecutar callback includeUppercase para PasswordFailureIncludeUppercase',
        () {
          // Arrange
          final failure = PasswordFailure.includeUppercase();
          var minLengthCallbackExecuted = false;
          var includeUppercaseCallbackExecuted = false;
          var includeLowercaseCallbackExecuted = false;
          var includeDigitCallbackExecuted = false;

          // Act
          failure.when(
            minLength: (failure) => minLengthCallbackExecuted = true,
            includeUppercase: (failure) =>
                includeUppercaseCallbackExecuted = true,
            includeLowercase: (failure) =>
                includeLowercaseCallbackExecuted = true,
            includeDigit: (failure) => includeDigitCallbackExecuted = true,
          );

          // Assert
          expect(minLengthCallbackExecuted, isFalse);
          expect(includeUppercaseCallbackExecuted, isTrue);
          expect(includeLowercaseCallbackExecuted, isFalse);
          expect(includeDigitCallbackExecuted, isFalse);
        },
      );

      test(
        'Debería ejecutar callback includeLowercase para PasswordFailureIncludeLowercase',
        () {
          // Arrange
          final failure = PasswordFailure.includeLowercase();
          var minLengthCallbackExecuted = false;
          var includeUppercaseCallbackExecuted = false;
          var includeLowercaseCallbackExecuted = false;
          var includeDigitCallbackExecuted = false;

          // Act
          failure.when(
            minLength: (failure) => minLengthCallbackExecuted = true,
            includeUppercase: (failure) =>
                includeUppercaseCallbackExecuted = true,
            includeLowercase: (failure) =>
                includeLowercaseCallbackExecuted = true,
            includeDigit: (failure) => includeDigitCallbackExecuted = true,
          );

          // Assert
          expect(minLengthCallbackExecuted, isFalse);
          expect(includeUppercaseCallbackExecuted, isFalse);
          expect(includeLowercaseCallbackExecuted, isTrue);
          expect(includeDigitCallbackExecuted, isFalse);
        },
      );

      test(
        'Debería ejecutar callback includeDigit para PasswordFailureIncludeDigit',
        () {
          // Arrange
          final failure = PasswordFailure.includeDigit();
          var minLengthCallbackExecuted = false;
          var includeUppercaseCallbackExecuted = false;
          var includeLowercaseCallbackExecuted = false;
          var includeDigitCallbackExecuted = false;

          // Act
          failure.when(
            minLength: (failure) => minLengthCallbackExecuted = true,
            includeUppercase: (failure) =>
                includeUppercaseCallbackExecuted = true,
            includeLowercase: (failure) =>
                includeLowercaseCallbackExecuted = true,
            includeDigit: (failure) => includeDigitCallbackExecuted = true,
          );

          // Assert
          expect(minLengthCallbackExecuted, isFalse);
          expect(includeUppercaseCallbackExecuted, isFalse);
          expect(includeLowercaseCallbackExecuted, isFalse);
          expect(includeDigitCallbackExecuted, isTrue);
        },
      );

      test('Debería pasar la instancia correcta a los callbacks', () {
        // Arrange
        final minLengthFailure = PasswordFailure.minLength(10);
        final includeUppercaseFailure = PasswordFailure.includeUppercase();
        final includeLowercaseFailure = PasswordFailure.includeLowercase();
        final includeDigitFailure = PasswordFailure.includeDigit();
        PasswordFailure? receivedMinLength;
        PasswordFailure? receivedIncludeUppercase;
        PasswordFailure? receivedIncludeLowercase;
        PasswordFailure? receivedIncludeDigit;

        // Act
        minLengthFailure.when(
          minLength: (failure) => receivedMinLength = failure,
          includeUppercase: (failure) => receivedIncludeUppercase = failure,
          includeLowercase: (failure) => receivedIncludeLowercase = failure,
          includeDigit: (failure) => receivedIncludeDigit = failure,
        );

        includeUppercaseFailure.when(
          minLength: (failure) => receivedMinLength = failure,
          includeUppercase: (failure) => receivedIncludeUppercase = failure,
          includeLowercase: (failure) => receivedIncludeLowercase = failure,
          includeDigit: (failure) => receivedIncludeDigit = failure,
        );

        includeLowercaseFailure.when(
          minLength: (failure) => receivedMinLength = failure,
          includeUppercase: (failure) => receivedIncludeUppercase = failure,
          includeLowercase: (failure) => receivedIncludeLowercase = failure,
          includeDigit: (failure) => receivedIncludeDigit = failure,
        );

        includeDigitFailure.when(
          minLength: (failure) => receivedMinLength = failure,
          includeUppercase: (failure) => receivedIncludeUppercase = failure,
          includeLowercase: (failure) => receivedIncludeLowercase = failure,
          includeDigit: (failure) => receivedIncludeDigit = failure,
        );

        // Assert
        expect(receivedMinLength, isA<PasswordFailureInvalidMinLength>());
        expect(
          receivedIncludeUppercase,
          isA<PasswordFailureIncludeUppercase>(),
        );
        expect(
          receivedIncludeLowercase,
          isA<PasswordFailureIncludeLowercase>(),
        );
        expect(receivedIncludeDigit, isA<PasswordFailureIncludeDigit>());
      });

      test('Debería pasar el min correcto en callback minLength', () {
        // Arrange
        const testMin = 12;
        final failure = PasswordFailure.minLength(testMin);
        int? receivedMin;

        // Act
        failure.when(
          minLength: (failure) => receivedMin = failure.min,
          includeUppercase: (failure) => fail('No debería ejecutarse'),
          includeLowercase: (failure) => fail('No debería ejecutarse'),
          includeDigit: (failure) => fail('No debería ejecutarse'),
        );

        // Assert
        expect(receivedMin, equals(testMin));
      });
    });

    group('map method', () {
      test('Debería mapear PasswordFailureInvalidMinLength correctamente', () {
        // Arrange
        final failure = PasswordFailure.minLength(8);

        // Act
        final result = failure.map<String>(
          minLength: (failure) => 'min_length_error_${failure.min}',
          includeUppercase: (failure) => 'uppercase_error',
          includeLowercase: (failure) => 'lowercase_error',
          includeDigit: (failure) => 'digit_error',
        );

        // Assert
        expect(result, equals('min_length_error_8'));
      });

      test('Debería mapear PasswordFailureIncludeUppercase correctamente', () {
        // Arrange
        final failure = PasswordFailure.includeUppercase();

        // Act
        final result = failure.map<String>(
          minLength: (failure) => 'min_length_error',
          includeUppercase: (failure) => 'uppercase_error',
          includeLowercase: (failure) => 'lowercase_error',
          includeDigit: (failure) => 'digit_error',
        );

        // Assert
        expect(result, equals('uppercase_error'));
      });

      test('Debería mapear PasswordFailureIncludeLowercase correctamente', () {
        // Arrange
        final failure = PasswordFailure.includeLowercase();

        // Act
        final result = failure.map<String>(
          minLength: (failure) => 'min_length_error',
          includeUppercase: (failure) => 'uppercase_error',
          includeLowercase: (failure) => 'lowercase_error',
          includeDigit: (failure) => 'digit_error',
        );

        // Assert
        expect(result, equals('lowercase_error'));
      });

      test('Debería mapear PasswordFailureIncludeDigit correctamente', () {
        // Arrange
        final failure = PasswordFailure.includeDigit();

        // Act
        final result = failure.map<String>(
          minLength: (failure) => 'min_length_error',
          includeUppercase: (failure) => 'uppercase_error',
          includeLowercase: (failure) => 'lowercase_error',
          includeDigit: (failure) => 'digit_error',
        );

        // Assert
        expect(result, equals('digit_error'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        final minLengthFailure = PasswordFailure.minLength(6);
        final uppercaseFailure = PasswordFailure.includeUppercase();

        // Act
        final intResult = minLengthFailure.map<int>(
          minLength: (failure) => failure.min,
          includeUppercase: (failure) => 2,
          includeLowercase: (failure) => 3,
          includeDigit: (failure) => 4,
        );

        final boolResult = uppercaseFailure.map<bool>(
          minLength: (failure) => true,
          includeUppercase: (failure) => false,
          includeLowercase: (failure) => true,
          includeDigit: (failure) => false,
        );

        // Assert
        expect(intResult, equals(6));
        expect(boolResult, equals(false));
      });
    });

    group('maybeWhen method', () {
      test('Debería ejecutar callback específico cuando está presente', () {
        // Arrange
        final failure = PasswordFailure.minLength(8);
        var minLengthExecuted = false;
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          minLength: (failure) => minLengthExecuted = true,
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(minLengthExecuted, isTrue);
        expect(orElseExecuted, isFalse);
      });

      test('Debería ejecutar orElse cuando callback específico es null', () {
        // Arrange
        final failure = PasswordFailure.minLength(8);
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          includeUppercase: (failure) => fail('No debería ejecutarse'),
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(orElseExecuted, isTrue);
      });

      test(
        'Debería ejecutar callback específico para PasswordFailureIncludeDigit',
        () {
          // Arrange
          final failure = PasswordFailure.includeDigit();
          var digitExecuted = false;
          var orElseExecuted = false;

          // Act
          failure.maybeWhen(
            includeDigit: (failure) => digitExecuted = true,
            orElse: () => orElseExecuted = true,
          );

          // Assert
          expect(digitExecuted, isTrue);
          expect(orElseExecuted, isFalse);
        },
      );
    });

    group('toString method', () {
      test(
        'Debería devolver "minLength" para PasswordFailureInvalidMinLength',
        () {
          // Arrange
          final failure = PasswordFailure.minLength(8);

          // Act
          final result = failure.toString();

          // Assert
          expect(result, equals('minLength'));
        },
      );

      test(
        'Debería devolver "includeUppercase" para PasswordFailureIncludeUppercase',
        () {
          // Arrange
          final failure = PasswordFailure.includeUppercase();

          // Act
          final result = failure.toString();

          // Assert
          expect(result, equals('includeUppercase'));
        },
      );

      test(
        'Debería devolver "includeLowercase" para PasswordFailureIncludeLowercase',
        () {
          // Arrange
          final failure = PasswordFailure.includeLowercase();

          // Act
          final result = failure.toString();

          // Assert
          expect(result, equals('includeLowercase'));
        },
      );

      test(
        'Debería devolver "includeDigit" para PasswordFailureIncludeDigit',
        () {
          // Arrange
          final failure = PasswordFailure.includeDigit();

          // Act
          final result = failure.toString();

          // Assert
          expect(result, equals('includeDigit'));
        },
      );
    });

    group('PasswordFailureInvalidMinLength properties', () {
      test('Debería mantener el valor de min', () {
        // Arrange
        const testMin = 16;

        // Act
        final failure = PasswordFailure.minLength(testMin);

        // Assert
        expect(
          (failure as PasswordFailureInvalidMinLength).min,
          equals(testMin),
        );
      });

      test('Debería crear diferentes instancias con diferentes min values', () {
        // Arrange & Act
        final failure1 = PasswordFailure.minLength(6);
        final failure2 = PasswordFailure.minLength(12);

        // Assert
        expect((failure1 as PasswordFailureInvalidMinLength).min, equals(6));
        expect((failure2 as PasswordFailureInvalidMinLength).min, equals(12));
        expect(failure1.min, isNot(equals(failure2.min)));
      });
    });

    group('Type checking', () {
      test('Debería identificar correctamente los tipos', () {
        // Arrange
        final minLength = PasswordFailure.minLength(8);
        final includeUppercase = PasswordFailure.includeUppercase();
        final includeLowercase = PasswordFailure.includeLowercase();
        final includeDigit = PasswordFailure.includeDigit();

        // Assert
        expect(minLength is PasswordFailureInvalidMinLength, isTrue);
        expect(minLength is PasswordFailureIncludeUppercase, isFalse);
        expect(minLength is PasswordFailureIncludeLowercase, isFalse);
        expect(minLength is PasswordFailureIncludeDigit, isFalse);

        expect(includeUppercase is PasswordFailureInvalidMinLength, isFalse);
        expect(includeUppercase is PasswordFailureIncludeUppercase, isTrue);
        expect(includeUppercase is PasswordFailureIncludeLowercase, isFalse);
        expect(includeUppercase is PasswordFailureIncludeDigit, isFalse);

        expect(includeLowercase is PasswordFailureInvalidMinLength, isFalse);
        expect(includeLowercase is PasswordFailureIncludeUppercase, isFalse);
        expect(includeLowercase is PasswordFailureIncludeLowercase, isTrue);
        expect(includeLowercase is PasswordFailureIncludeDigit, isFalse);

        expect(includeDigit is PasswordFailureInvalidMinLength, isFalse);
        expect(includeDigit is PasswordFailureIncludeUppercase, isFalse);
        expect(includeDigit is PasswordFailureIncludeLowercase, isFalse);
        expect(includeDigit is PasswordFailureIncludeDigit, isTrue);
      });
    });
  });
}
