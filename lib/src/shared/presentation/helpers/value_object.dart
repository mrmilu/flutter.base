import 'package:flutter/foundation.dart';

import 'either.dart';

@immutable
abstract class ValueObject<L, R> {
  const ValueObject();
  Either<L, R> get value;

  bool isValid() => value.isRight();

  bool isInvalid() => value.isLeft();

  R getOrCrash() => value.rightOrElse((l) => throw UnexpectedValueError<L>(l));

  R getOrElse(R orElse) => value.rightOrElse((_) => orElse);

  void when({
    required void Function(L) isLeft,
    required void Function(R) isRight,
  }) => value.when(isLeft: isLeft, isRight: isRight);

  T map<T>({required T Function(L) isLeft, required T Function(R) isRight}) =>
      value.map(isLeft: isLeft, isRight: isRight);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<L, R> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

class UnexpectedValueError<T> extends Error {
  final T valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $valueFailure');
  }
}
