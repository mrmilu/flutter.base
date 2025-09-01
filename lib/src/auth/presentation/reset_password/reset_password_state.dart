part of 'reset_password_cubit.dart';

@freezed
abstract class ResetPasswordState with _$ResetPasswordState {
  factory ResetPasswordState({
    required String password,
    required String passwordRepeat,
    required bool showError,
    required ResultOr<GeneralBaseFailure> resultOr,
  }) = _ResetPasswordState;

  factory ResetPasswordState.initial() => _ResetPasswordState(
    password: '',
    passwordRepeat: '',
    showError: false,
    resultOr: ResultOr.none(),
  );
}
