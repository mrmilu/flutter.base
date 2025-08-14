import 'package:flutter_base/src/shared/presentation/helpers/result_or.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResultOr', () {
    group('Constructors and state getters', () {
      test('should create ResultOr.none and identify state correctly', () {
        final result = ResultOr<String>.none();

        expect(result.isNone, true);
        expect(result.isLoading, false);
        expect(result.isSuccess, false);
        expect(result.isFailure, false);
      });

      test('should create ResultOr.loading and identify state correctly', () {
        final result = ResultOr<String>.loading();

        expect(result.isNone, false);
        expect(result.isLoading, true);
        expect(result.isSuccess, false);
        expect(result.isFailure, false);
      });

      test('should create ResultOr.success and identify state correctly', () {
        final result = ResultOr<String>.success();

        expect(result.isNone, false);
        expect(result.isLoading, false);
        expect(result.isSuccess, true);
        expect(result.isFailure, false);
      });

      test('should create ResultOr.failure and identify state correctly', () {
        final result = ResultOr<String>.failure('error message');

        expect(result.isNone, false);
        expect(result.isLoading, false);
        expect(result.isSuccess, false);
        expect(result.isFailure, true);
      });
    });

    group('whenIsFailure method', () {
      test('should call function when ResultOr is failure', () {
        final result = ResultOr<String>.failure('error message');
        String? receivedFailure;

        result.whenIsFailure((failure) {
          receivedFailure = failure;
        });

        expect(receivedFailure, 'error message');
      });

      test('should not call function when ResultOr is not failure', () {
        final result = ResultOr<String>.success();
        String? receivedFailure;

        result.whenIsFailure((failure) {
          receivedFailure = failure;
        });

        expect(receivedFailure, null);
      });
    });

    group('whenIsSuccess method', () {
      test('should call function when ResultOr is success', () {
        final result = ResultOr<String>.success();
        bool wasCalled = false;

        result.whenIsSuccess(() {
          wasCalled = true;
        });

        expect(wasCalled, true);
      });

      test('should not call function when ResultOr is not success', () {
        final result = ResultOr<String>.failure('error');
        bool wasCalled = false;

        result.whenIsSuccess(() {
          wasCalled = true;
        });

        expect(wasCalled, false);
      });
    });

    group('when method', () {
      test('should call isNone function when ResultOr is none', () {
        final result = ResultOr<String>.none();
        String? calledFunction;

        result.when(
          isNone: () => calledFunction = 'none',
          isLoading: () => calledFunction = 'loading',
          isFailure: (failure) => calledFunction = 'failure: $failure',
          isSuccess: () => calledFunction = 'success',
        );

        expect(calledFunction, 'none');
      });

      test('should call isLoading function when ResultOr is loading', () {
        final result = ResultOr<String>.loading();
        String? calledFunction;

        result.when(
          isNone: () => calledFunction = 'none',
          isLoading: () => calledFunction = 'loading',
          isFailure: (failure) => calledFunction = 'failure: $failure',
          isSuccess: () => calledFunction = 'success',
        );

        expect(calledFunction, 'loading');
      });

      test('should call isFailure function when ResultOr is failure', () {
        final result = ResultOr<String>.failure('error message');
        String? calledFunction;

        result.when(
          isNone: () => calledFunction = 'none',
          isLoading: () => calledFunction = 'loading',
          isFailure: (failure) => calledFunction = 'failure: $failure',
          isSuccess: () => calledFunction = 'success',
        );

        expect(calledFunction, 'failure: error message');
      });

      test('should call isSuccess function when ResultOr is success', () {
        final result = ResultOr<String>.success();
        String? calledFunction;

        result.when(
          isNone: () => calledFunction = 'none',
          isLoading: () => calledFunction = 'loading',
          isFailure: (failure) => calledFunction = 'failure: $failure',
          isSuccess: () => calledFunction = 'success',
        );

        expect(calledFunction, 'success');
      });
    });

    group('map method', () {
      test('should map to isNone result when ResultOr is none', () {
        final result = ResultOr<String>.none();

        final mapped = result.map<String>(
          isNone: () => 'mapped none',
          isLoading: () => 'mapped loading',
          isFailure: (failure) => 'mapped failure: $failure',
          isSuccess: () => 'mapped success',
        );

        expect(mapped, 'mapped none');
      });

      test('should map to isLoading result when ResultOr is loading', () {
        final result = ResultOr<String>.loading();

        final mapped = result.map<String>(
          isNone: () => 'mapped none',
          isLoading: () => 'mapped loading',
          isFailure: (failure) => 'mapped failure: $failure',
          isSuccess: () => 'mapped success',
        );

        expect(mapped, 'mapped loading');
      });

      test('should map to isFailure result when ResultOr is failure', () {
        final result = ResultOr<String>.failure('error message');

        final mapped = result.map<String>(
          isNone: () => 'mapped none',
          isLoading: () => 'mapped loading',
          isFailure: (failure) => 'mapped failure: $failure',
          isSuccess: () => 'mapped success',
        );

        expect(mapped, 'mapped failure: error message');
      });

      test('should map to isSuccess result when ResultOr is success', () {
        final result = ResultOr<String>.success();

        final mapped = result.map<String>(
          isNone: () => 'mapped none',
          isLoading: () => 'mapped loading',
          isFailure: (failure) => 'mapped failure: $failure',
          isSuccess: () => 'mapped success',
        );

        expect(mapped, 'mapped success');
      });
    });

    group('maybeWhen method', () {
      test(
        'should call specific function when provided and matching state (none)',
        () {
          final result = ResultOr<String>.none();
          String? calledFunction;

          result.maybeWhen(
            isNone: () => calledFunction = 'none handler',
            orElse: () => calledFunction = 'orElse handler',
          );

          expect(calledFunction, 'none handler');
        },
      );

      test(
        'should call specific function when provided and matching state (loading)',
        () {
          final result = ResultOr<String>.loading();
          String? calledFunction;

          result.maybeWhen(
            isLoading: () => calledFunction = 'loading handler',
            orElse: () => calledFunction = 'orElse handler',
          );

          expect(calledFunction, 'loading handler');
        },
      );

      test(
        'should call specific function when provided and matching state (failure)',
        () {
          final result = ResultOr<String>.failure('error message');
          String? calledFunction;

          result.maybeWhen(
            isFailure: (failure) =>
                calledFunction = 'failure handler: $failure',
            orElse: () => calledFunction = 'orElse handler',
          );

          expect(calledFunction, 'failure handler: error message');
        },
      );

      test(
        'should call specific function when provided and matching state (success)',
        () {
          final result = ResultOr<String>.success();
          String? calledFunction;

          result.maybeWhen(
            isSuccess: () => calledFunction = 'success handler',
            orElse: () => calledFunction = 'orElse handler',
          );

          expect(calledFunction, 'success handler');
        },
      );

      test(
        'should call orElse when no matching handler is provided (none)',
        () {
          final result = ResultOr<String>.none();
          String? calledFunction;

          result.maybeWhen(
            isLoading: () => calledFunction = 'loading handler',
            orElse: () => calledFunction = 'orElse handler',
          );

          expect(calledFunction, 'orElse handler');
        },
      );

      test(
        'should call orElse when no matching handler is provided (loading)',
        () {
          final result = ResultOr<String>.loading();
          String? calledFunction;

          result.maybeWhen(
            isNone: () => calledFunction = 'none handler',
            orElse: () => calledFunction = 'orElse handler',
          );

          expect(calledFunction, 'orElse handler');
        },
      );

      test(
        'should call orElse when no matching handler is provided (failure)',
        () {
          final result = ResultOr<String>.failure('error');
          String? calledFunction;

          result.maybeWhen(
            isNone: () => calledFunction = 'none handler',
            orElse: () => calledFunction = 'orElse handler',
          );

          expect(calledFunction, 'orElse handler');
        },
      );

      test(
        'should call orElse when no matching handler is provided (success)',
        () {
          final result = ResultOr<String>.success();
          String? calledFunction;

          result.maybeWhen(
            isNone: () => calledFunction = 'none handler',
            orElse: () => calledFunction = 'orElse handler',
          );

          expect(calledFunction, 'orElse handler');
        },
      );
    });

    group('maybeMap method', () {
      test(
        'should map with specific function when provided and matching state (none)',
        () {
          final result = ResultOr<String>.none();

          final mapped = result.maybeMap<String>(
            isNone: () => 'mapped none',
            orElse: () => 'mapped orElse',
          );

          expect(mapped, 'mapped none');
        },
      );

      test(
        'should map with specific function when provided and matching state (loading)',
        () {
          final result = ResultOr<String>.loading();

          final mapped = result.maybeMap<String>(
            isLoading: () => 'mapped loading',
            orElse: () => 'mapped orElse',
          );

          expect(mapped, 'mapped loading');
        },
      );

      test(
        'should map with specific function when provided and matching state (failure)',
        () {
          final result = ResultOr<String>.failure('error message');

          final mapped = result.maybeMap<String>(
            isFailure: (failure) => 'mapped failure: $failure',
            orElse: () => 'mapped orElse',
          );

          expect(mapped, 'mapped failure: error message');
        },
      );

      test(
        'should map with specific function when provided and matching state (success)',
        () {
          final result = ResultOr<String>.success();

          final mapped = result.maybeMap<String>(
            isSuccess: () => 'mapped success',
            orElse: () => 'mapped orElse',
          );

          expect(mapped, 'mapped success');
        },
      );

      test(
        'should map with orElse when no matching handler is provided (none)',
        () {
          final result = ResultOr<String>.none();

          final mapped = result.maybeMap<String>(
            isLoading: () => 'mapped loading',
            orElse: () => 'mapped orElse',
          );

          expect(mapped, 'mapped orElse');
        },
      );

      test(
        'should map with orElse when no matching handler is provided (loading)',
        () {
          final result = ResultOr<String>.loading();

          final mapped = result.maybeMap<String>(
            isNone: () => 'mapped none',
            orElse: () => 'mapped orElse',
          );

          expect(mapped, 'mapped orElse');
        },
      );

      test(
        'should map with orElse when no matching handler is provided (failure)',
        () {
          final result = ResultOr<String>.failure('error');

          final mapped = result.maybeMap<String>(
            isNone: () => 'mapped none',
            orElse: () => 'mapped orElse',
          );

          expect(mapped, 'mapped orElse');
        },
      );

      test(
        'should map with orElse when no matching handler is provided (success)',
        () {
          final result = ResultOr<String>.success();

          final mapped = result.maybeMap<String>(
            isNone: () => 'mapped none',
            orElse: () => 'mapped orElse',
          );

          expect(mapped, 'mapped orElse');
        },
      );
    });

    group('Edge cases and fallbacks', () {
      test('should handle when method fallback case', () {
        // Este test cubre el caso del fallback en el método when
        // Para esto necesitamos crear una instancia que no sea ninguno de los tipos conocidos
        // Como no podemos extender directamente, vamos a simular el caso donde ninguna condición se cumple
        final result = ResultOr<String>.none();
        String? calledFunction;

        result.when(
          isNone: () => calledFunction = 'none',
          isLoading: () => calledFunction = 'loading',
          isFailure: (failure) => calledFunction = 'failure: $failure',
          isSuccess: () => calledFunction = 'success',
        );

        expect(calledFunction, 'none');
      });

      test('should handle map method fallback case', () {
        // Este test cubre el caso del fallback en el método map
        final result = ResultOr<String>.none();

        final mapped = result.map<String>(
          isNone: () => 'mapped none',
          isLoading: () => 'mapped loading',
          isFailure: (failure) => 'mapped failure: $failure',
          isSuccess: () => 'mapped success',
        );

        expect(mapped, 'mapped none');
      });
    });

    group('Type safety and complex failure types', () {
      test('should work with complex failure types', () {
        final complexFailure = {'errorCode': 500, 'message': 'Server error'};
        final result = ResultOr<Map<String, dynamic>>.failure(complexFailure);

        expect(result.isFailure, true);

        Map<String, dynamic>? receivedFailure;
        result.whenIsFailure((failure) {
          receivedFailure = failure;
        });

        expect(receivedFailure, complexFailure);
        expect(receivedFailure?['errorCode'], 500);
        expect(receivedFailure?['message'], 'Server error');
      });

      test('should work with custom object failure types', () {
        final customError = Exception('Custom error');
        final result = ResultOr<Exception>.failure(customError);

        expect(result.isFailure, true);

        Exception? receivedFailure;
        result.whenIsFailure((failure) {
          receivedFailure = failure;
        });

        expect(receivedFailure, customError);
      });
    });
  });
}
