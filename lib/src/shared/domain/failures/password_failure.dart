import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_failure.freezed.dart';

@freezed
abstract class PasswordFailure with _$PasswordFailure {
  const factory PasswordFailure.empty({
    @Default('empty') String code,
  }) = PasswordFailureEmpty;

  const factory PasswordFailure.minLength({
    @Default('minLength') String code,
    required int length,
  }) = PasswordFailureInvalidMinLength;

  const factory PasswordFailure.includeUppercase({
    @Default('includeUppercase') String code,
  }) = PasswordFailureIncludeUppercase;

  const factory PasswordFailure.includeLowercase({
    @Default('includeLowercase') String code,
  }) = PasswordFailureIncludeLowercase;

  const factory PasswordFailure.includeDigit({
    @Default('includeDigit') String code,
  }) = PasswordFailureIncludeDigit;

  const PasswordFailure._();

  int get maxLength {
    return when(
      empty: (_) => 0,
      minLength: (_, length) => length,
      includeUppercase: (_) => 0,
      includeLowercase: (_) => 0,
      includeDigit: (_) => 0,
    );
  }
}
