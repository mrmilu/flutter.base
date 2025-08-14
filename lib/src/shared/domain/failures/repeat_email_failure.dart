import 'package:freezed_annotation/freezed_annotation.dart';

part 'repeat_email_failure.freezed.dart';

@freezed
abstract class RepeatEmailFailure with _$RepeatEmailFailure {
  const factory RepeatEmailFailure.mismatched({
    @Default('mismatched') String code,
  }) = RepeatEmailFailureMismatched;

  const RepeatEmailFailure._();
}
