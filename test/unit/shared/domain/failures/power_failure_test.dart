import 'package:flutter_base/src/shared/domain/failures/power_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PowerFailure', () {
    group('Factory constructors', () {
      test('Debería crear PowerFailureEmpty correctamente', () {
        // Act
        final failure = PowerFailure.empty();

        // Assert
        expect(failure, isA<PowerFailureEmpty>());
        expect(failure.runtimeType, equals(PowerFailureEmpty));
      });

      test('Debería crear PowerFailureInvalid correctamente', () {
        // Act
        final failure = PowerFailure.invalid();

        // Assert
        expect(failure, isA<PowerFailureInvalid>());
        expect(failure.runtimeType, equals(PowerFailureInvalid));
      });

      test('Debería crear PowerFailureLess correctamente', () {
        // Act
        final failure = PowerFailure.less();

        // Assert
        expect(failure, isA<PowerFailureLess>());
        expect(failure.runtimeType, equals(PowerFailureLess));
      });

      test('Debería crear PowerFailureMore correctamente', () {
        // Act
        final failure = PowerFailure.more();

        // Assert
        expect(failure, isA<PowerFailureMore>());
        expect(failure.runtimeType, equals(PowerFailureMore));
      });
    });

    group('when method', () {
      test('Debería ejecutar callback empty para PowerFailureEmpty', () {
        // Arrange
        final failure = PowerFailure.empty();
        var emptyCallbackExecuted = false;
        var invalidCallbackExecuted = false;
        var lessCallbackExecuted = false;
        var moreCallbackExecuted = false;

        // Act
        failure.when(
          empty: (failure) => emptyCallbackExecuted = true,
          invalid: (failure) => invalidCallbackExecuted = true,
          less: (failure) => lessCallbackExecuted = true,
          more: (failure) => moreCallbackExecuted = true,
        );

        // Assert
        expect(emptyCallbackExecuted, isTrue);
        expect(invalidCallbackExecuted, isFalse);
        expect(lessCallbackExecuted, isFalse);
        expect(moreCallbackExecuted, isFalse);
      });

      test('Debería ejecutar callback invalid para PowerFailureInvalid', () {
        // Arrange
        final failure = PowerFailure.invalid();
        var emptyCallbackExecuted = false;
        var invalidCallbackExecuted = false;
        var lessCallbackExecuted = false;
        var moreCallbackExecuted = false;

        // Act
        failure.when(
          empty: (failure) => emptyCallbackExecuted = true,
          invalid: (failure) => invalidCallbackExecuted = true,
          less: (failure) => lessCallbackExecuted = true,
          more: (failure) => moreCallbackExecuted = true,
        );

        // Assert
        expect(emptyCallbackExecuted, isFalse);
        expect(invalidCallbackExecuted, isTrue);
        expect(lessCallbackExecuted, isFalse);
        expect(moreCallbackExecuted, isFalse);
      });

      test('Debería ejecutar callback less para PowerFailureLess', () {
        // Arrange
        final failure = PowerFailure.less();
        var emptyCallbackExecuted = false;
        var invalidCallbackExecuted = false;
        var lessCallbackExecuted = false;
        var moreCallbackExecuted = false;

        // Act
        failure.when(
          empty: (failure) => emptyCallbackExecuted = true,
          invalid: (failure) => invalidCallbackExecuted = true,
          less: (failure) => lessCallbackExecuted = true,
          more: (failure) => moreCallbackExecuted = true,
        );

        // Assert
        expect(emptyCallbackExecuted, isFalse);
        expect(invalidCallbackExecuted, isFalse);
        expect(lessCallbackExecuted, isTrue);
        expect(moreCallbackExecuted, isFalse);
      });

      test('Debería ejecutar callback more para PowerFailureMore', () {
        // Arrange
        final failure = PowerFailure.more();
        var emptyCallbackExecuted = false;
        var invalidCallbackExecuted = false;
        var lessCallbackExecuted = false;
        var moreCallbackExecuted = false;

        // Act
        failure.when(
          empty: (failure) => emptyCallbackExecuted = true,
          invalid: (failure) => invalidCallbackExecuted = true,
          less: (failure) => lessCallbackExecuted = true,
          more: (failure) => moreCallbackExecuted = true,
        );

        // Assert
        expect(emptyCallbackExecuted, isFalse);
        expect(invalidCallbackExecuted, isFalse);
        expect(lessCallbackExecuted, isFalse);
        expect(moreCallbackExecuted, isTrue);
      });

      test('Debería pasar la instancia correcta a los callbacks', () {
        // Arrange
        final emptyFailure = PowerFailure.empty();
        final invalidFailure = PowerFailure.invalid();
        final lessFailure = PowerFailure.less();
        final moreFailure = PowerFailure.more();
        PowerFailure? receivedEmpty;
        PowerFailure? receivedInvalid;
        PowerFailure? receivedLess;
        PowerFailure? receivedMore;

        // Act
        emptyFailure.when(
          empty: (failure) => receivedEmpty = failure,
          invalid: (failure) => receivedInvalid = failure,
          less: (failure) => receivedLess = failure,
          more: (failure) => receivedMore = failure,
        );

        invalidFailure.when(
          empty: (failure) => receivedEmpty = failure,
          invalid: (failure) => receivedInvalid = failure,
          less: (failure) => receivedLess = failure,
          more: (failure) => receivedMore = failure,
        );

        lessFailure.when(
          empty: (failure) => receivedEmpty = failure,
          invalid: (failure) => receivedInvalid = failure,
          less: (failure) => receivedLess = failure,
          more: (failure) => receivedMore = failure,
        );

        moreFailure.when(
          empty: (failure) => receivedEmpty = failure,
          invalid: (failure) => receivedInvalid = failure,
          less: (failure) => receivedLess = failure,
          more: (failure) => receivedMore = failure,
        );

        // Assert
        expect(receivedEmpty, isA<PowerFailureEmpty>());
        expect(receivedInvalid, isA<PowerFailureInvalid>());
        expect(receivedLess, isA<PowerFailureLess>());
        expect(receivedMore, isA<PowerFailureMore>());
      });
    });

    group('map method', () {
      test('Debería mapear PowerFailureEmpty correctamente', () {
        // Arrange
        final failure = PowerFailure.empty();

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
          less: (failure) => 'less_error',
          more: (failure) => 'more_error',
        );

        // Assert
        expect(result, equals('empty_error'));
      });

      test('Debería mapear PowerFailureInvalid correctamente', () {
        // Arrange
        final failure = PowerFailure.invalid();

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
          less: (failure) => 'less_error',
          more: (failure) => 'more_error',
        );

        // Assert
        expect(result, equals('invalid_error'));
      });

      test('Debería mapear PowerFailureLess correctamente', () {
        // Arrange
        final failure = PowerFailure.less();

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
          less: (failure) => 'less_error',
          more: (failure) => 'more_error',
        );

        // Assert
        expect(result, equals('less_error'));
      });

      test('Debería mapear PowerFailureMore correctamente', () {
        // Arrange
        final failure = PowerFailure.more();

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
          less: (failure) => 'less_error',
          more: (failure) => 'more_error',
        );

        // Assert
        expect(result, equals('more_error'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        final emptyFailure = PowerFailure.empty();
        final invalidFailure = PowerFailure.invalid();

        // Act
        final intResult = emptyFailure.map<int>(
          empty: (failure) => 1,
          invalid: (failure) => 2,
          less: (failure) => 3,
          more: (failure) => 4,
        );

        final boolResult = invalidFailure.map<bool>(
          empty: (failure) => true,
          invalid: (failure) => false,
          less: (failure) => true,
          more: (failure) => false,
        );

        // Assert
        expect(intResult, equals(1));
        expect(boolResult, equals(false));
      });
    });

    group('maybeWhen method', () {
      test('Debería ejecutar callback específico cuando está presente', () {
        // Arrange
        final failure = PowerFailure.empty();
        var emptyExecuted = false;
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          empty: (failure) => emptyExecuted = true,
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(emptyExecuted, isTrue);
        expect(orElseExecuted, isFalse);
      });

      test('Debería ejecutar orElse cuando callback específico es null', () {
        // Arrange
        final failure = PowerFailure.empty();
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          invalid: (failure) => fail('No debería ejecutarse'),
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(orElseExecuted, isTrue);
      });

      test('Debería ejecutar orElse cuando no hay callback matching', () {
        // Arrange
        final failure = PowerFailure.less();
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          empty: (failure) => fail('No debería ejecutarse'),
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(orElseExecuted, isTrue);
      });

      test('Debería ejecutar callback específico para PowerFailureMore', () {
        // Arrange
        final failure = PowerFailure.more();
        var moreExecuted = false;
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          more: (failure) => moreExecuted = true,
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(moreExecuted, isTrue);
        expect(orElseExecuted, isFalse);
      });
    });

    group('Equality and hashCode', () {
      test('Debería considerar iguales instancias del mismo tipo', () {
        // Arrange
        final empty1 = PowerFailure.empty();
        final empty2 = PowerFailure.empty();
        final invalid1 = PowerFailure.invalid();
        final invalid2 = PowerFailure.invalid();
        final less1 = PowerFailure.less();
        final less2 = PowerFailure.less();
        final more1 = PowerFailure.more();
        final more2 = PowerFailure.more();

        // Assert
        expect(empty1.runtimeType, equals(empty2.runtimeType));
        expect(invalid1.runtimeType, equals(invalid2.runtimeType));
        expect(less1.runtimeType, equals(less2.runtimeType));
        expect(more1.runtimeType, equals(more2.runtimeType));
        expect(empty1.runtimeType, isNot(equals(invalid1.runtimeType)));
        expect(empty1.runtimeType, isNot(equals(less1.runtimeType)));
        expect(empty1.runtimeType, isNot(equals(more1.runtimeType)));
      });
    });

    group('Type checking', () {
      test('Debería identificar correctamente los tipos', () {
        // Arrange
        final empty = PowerFailure.empty();
        final invalid = PowerFailure.invalid();
        final less = PowerFailure.less();
        final more = PowerFailure.more();

        // Assert
        expect(empty is PowerFailureEmpty, isTrue);
        expect(empty is PowerFailureInvalid, isFalse);
        expect(empty is PowerFailureLess, isFalse);
        expect(empty is PowerFailureMore, isFalse);

        expect(invalid is PowerFailureEmpty, isFalse);
        expect(invalid is PowerFailureInvalid, isTrue);
        expect(invalid is PowerFailureLess, isFalse);
        expect(invalid is PowerFailureMore, isFalse);

        expect(less is PowerFailureEmpty, isFalse);
        expect(less is PowerFailureInvalid, isFalse);
        expect(less is PowerFailureLess, isTrue);
        expect(less is PowerFailureMore, isFalse);

        expect(more is PowerFailureEmpty, isFalse);
        expect(more is PowerFailureInvalid, isFalse);
        expect(more is PowerFailureLess, isFalse);
        expect(more is PowerFailureMore, isTrue);
      });
    });
  });
}
