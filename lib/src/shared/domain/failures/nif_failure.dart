import 'package:freezed_annotation/freezed_annotation.dart';

part 'nif_failure.freezed.dart';

@freezed
abstract class NifFailure with _$NifFailure {
  const factory NifFailure.empty({
    @Default('empty') String code,
  }) = NifFailureEmpty;

  const factory NifFailure.invalid({
    @Default('invalid') String code,
  }) = NifFailureInvalid;

  const factory NifFailure.tooLong({
    @Default('tooLong') String code,
    required int length,
  }) = NifFailureTooLong;

  const factory NifFailure.tooShort({
    @Default('tooShort') String code,
    required int length,
  }) = NifFailureTooShort;

  const NifFailure._();

  int get maxLength {
    return when(
      empty: (_) => 0,
      invalid: (_) => 0,
      tooLong: (_, length) => length,
      tooShort: (_, length) => length,
    );
  }
}
