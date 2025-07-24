part of 'change_email_cubit.dart';

@freezed
abstract class ChangeEmailState with _$ChangeEmailState {
  factory ChangeEmailState({
    required EmailVos email,
    required String emailRepeat,
    required bool showError,
    required ResultOr<ChangeEmailFailure> resultOr,
  }) = _ChangeEmailState;

  factory ChangeEmailState.initial() => _ChangeEmailState(
    email: EmailVos(''),
    emailRepeat: '',
    showError: false,
    resultOr: ResultOr.none(),
  );
}
