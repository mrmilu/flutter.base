part of 'signin_cubit.dart';

@freezed
abstract class SigninState with _$SigninState {
  factory SigninState({
    required String email,
    required String password,
    required bool showErrors,
    required ResultOr<SignInFailure> resultOr,
  }) = _SigninState;

  factory SigninState.initial() => _SigninState(
    email: '',
    password: '',
    showErrors: false,
    resultOr: ResultOr.none(),
  );

  SigninState._();

  EmailVos get emailVos => EmailVos(email);

  PasswordVos get passwordVos => PasswordVos(password);
}
