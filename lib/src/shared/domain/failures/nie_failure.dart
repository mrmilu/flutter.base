import 'package:freezed_annotation/freezed_annotation.dart';

part 'nie_failure.freezed.dart';

@freezed
abstract class NieFailure with _$NieFailure {
  const factory NieFailure.empty({
    @Default('empty') String code,
  }) = NieFailureEmpty;

  const factory NieFailure.invalid({
    @Default('invalid') String code,
  }) = NieFailureInvalid;

  const factory NieFailure.tooLong({
    @Default('tooLong') String code,
    required int length,
  }) = NieFailureTooLong;

  const factory NieFailure.tooShort({
    @Default('tooShort') String code,
    required int length,
  }) = NieFailureTooShort;

  const NieFailure._();

  int get maxLength {
    return when(
      empty: (_) => 0,
      invalid: (_) => 0,
      tooLong: (_, length) => length,
      tooShort: (_, length) => length,
    );
  }
}
