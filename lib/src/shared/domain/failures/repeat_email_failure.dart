import 'package:freezed_annotation/freezed_annotation.dart';

part 'repeat_email_failure.freezed.dart';

@Freezed(copyWith: false)
abstract class RepeatEmailFailure with _$RepeatEmailFailure {
  const factory RepeatEmailFailure.mismatched({
    @Default('mismatched') String code,
  }) = RepeatEmailFailureMismatched;

  const RepeatEmailFailure._();
}
