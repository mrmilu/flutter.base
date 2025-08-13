import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_failure.freezed.dart';

@freezed
abstract class EmailFailure with _$EmailFailure {
  const factory EmailFailure.empty({
    @Default('empty') String code,
  }) = EmailFailureEmpty;

  const factory EmailFailure.invalid({
    @Default('invalid') String code,
  }) = EmailFailureInvalid;

  const EmailFailure._();
}
