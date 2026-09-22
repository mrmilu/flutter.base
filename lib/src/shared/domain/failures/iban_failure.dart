import 'package:freezed_annotation/freezed_annotation.dart';

part 'iban_failure.freezed.dart';

@freezed
abstract class IbanFailure with _$IbanFailure {
  const factory IbanFailure.empty({
    @Default('empty') String code,
  }) = IbanFailureEmpty;

  const factory IbanFailure.invalid({
    @Default('invalid') String code,
  }) = IbanFailureInvalid;

  const factory IbanFailure.tooLong({
    @Default('tooLong') String code,
    required int length,
  }) = IbanFailureTooLong;

  const factory IbanFailure.tooShort({
    @Default('tooShort') String code,
    required int length,
  }) = IbanFailureTooShort;

  const factory IbanFailure.invalidFormat({
    @Default('invalidFormat') String code,
  }) = IbanFailureInvalidFormat;

  const factory IbanFailure.invalidChecksum({
    @Default('invalidChecksum') String code,
  }) = IbanFailureInvalidChecksum;

  const IbanFailure._();

  int get maxLength {
    return when(
      empty: (_) => 0,
      invalid: (_) => 0,
      tooLong: (_, length) => length,
      tooShort: (_, length) => length,
      invalidFormat: (_) => 0,
      invalidChecksum: (_) => 0,
    );
  }
}
