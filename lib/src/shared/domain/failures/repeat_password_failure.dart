import 'package:freezed_annotation/freezed_annotation.dart';

part 'repeat_password_failure.freezed.dart';

@Freezed(copyWith: false)
abstract class RepeatPasswordFailure with _$RepeatPasswordFailure {
  const factory RepeatPasswordFailure.mismatched({
    @Default('mismatched') String code,
  }) = RepeatPasswordFailureMismatched;

  const RepeatPasswordFailure._();
}
