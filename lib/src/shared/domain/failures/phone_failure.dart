import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_failure.freezed.dart';

@freezed
abstract class PhoneFailure with _$PhoneFailure {
  const factory PhoneFailure.empty({
    @Default('empty') String code,
  }) = PhoneFailureEmpty;

  const factory PhoneFailure.invalid({
    @Default('invalid') String code,
  }) = PhoneFailureInvalid;

  const factory PhoneFailure.tooLong({
    @Default('tooLong') String code,
    required int length,
  }) = PhoneFailureTooLong;

  const PhoneFailure._();

  int get maxLength {
    return when(
      empty: (_) => 0,
      invalid: (_) => 0,
      tooLong: (_, length) => length,
    );
  }
}
