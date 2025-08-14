part of 'forgot_password_cubit.dart';

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  factory ForgotPasswordState({
    required String email,
    required bool showErrors,
    required ResultOr<SigninFailure> resultOr,
  }) = _ForgotPasswordState;

  factory ForgotPasswordState.initial() => _ForgotPasswordState(
    email: '',
    showErrors: false,
    resultOr: ResultOr.none(),
  );

  ForgotPasswordState._();

  EmailVos get emailVos => EmailVos(email);
}
