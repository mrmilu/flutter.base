part of 'signin_cubit.dart';

@freezed
abstract class SigninState with _$SigninState {
  factory SigninState({
    required String email,
    required String password,
    required bool showErrors,
    required bool rememberMe,
    required ResultOr<SigninFailure> resultOr,
  }) = _SigninState;

  factory SigninState.initial() => _SigninState(
    email: '',
    password: '',
    showErrors: false,
    rememberMe: false,
    resultOr: ResultOr.none(),
  );

  SigninState._();

  EmailVos get emailVos => EmailVos(email);

  PasswordVos get passwordVos => PasswordVos(password);
}
