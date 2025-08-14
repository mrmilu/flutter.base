import 'package:freezed_annotation/freezed_annotation.dart';

part 'fullname_failure.freezed.dart';

@freezed
abstract class FullnameFailure with _$FullnameFailure {
  const factory FullnameFailure.empty({
    @Default('empty') String code,
  }) = FullnameFailureEmpty;

  const factory FullnameFailure.invalid({
    @Default('invalid') String code,
  }) = FullnameFailureInvalid;

  const factory FullnameFailure.tooLong({
    @Default('tooLong') String code,
    required int length,
  }) = FullnameFailureTooLong;

  const FullnameFailure._();

  int get maxLength {
    return when(
      empty: (_) => 0,
      invalid: (_) => 0,
      tooLong: (_, length) => length,
    );
  }
}
