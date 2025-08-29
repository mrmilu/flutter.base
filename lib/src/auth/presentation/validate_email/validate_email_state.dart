part of 'validate_email_cubit.dart';

@freezed
abstract class ValidateEmailState with _$ValidateEmailState {
  factory ValidateEmailState({
    required ResultOr<ValidateEmailFailure> resultOr,
  }) = _ValidateEmailState;

  factory ValidateEmailState.initial() => _ValidateEmailState(
    resultOr: ResultOr.none(),
  );
}
