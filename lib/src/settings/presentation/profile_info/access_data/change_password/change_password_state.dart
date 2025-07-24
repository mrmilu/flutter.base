part of 'change_password_cubit.dart';

@freezed
abstract class ChangePasswordState with _$ChangePasswordState {
  factory ChangePasswordState({
    required String oldPassword,
    required String password,
    required String passwordRepeat,
    required bool showError,
    required ResultOr<ChangePasswordFailure> resultOr,
  }) = _ChangePasswordState;

  factory ChangePasswordState.initial() => _ChangePasswordState(
    oldPassword: '',
    password: '',
    passwordRepeat: '',
    showError: false,
    resultOr: ResultOr.none(),
  );
}
