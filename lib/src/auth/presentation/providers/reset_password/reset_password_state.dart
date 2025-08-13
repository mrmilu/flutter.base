part of 'reset_password_cubit.dart';

@freezed
abstract class ResetPasswordState with _$ResetPasswordState {
  factory ResetPasswordState({
    required String password,
    required String repeatPassword,
    required bool showErrors,
    required ResultOr<GeneralBaseFailure> resultOr,
  }) = _ResetPasswordState;

  factory ResetPasswordState.initial() => _ResetPasswordState(
    password: '',
    repeatPassword: '',
    showErrors: false,
    resultOr: ResultOr.none(),
  );

  ResetPasswordState._();

  PasswordVos get passwordVos => PasswordVos(password);
}
