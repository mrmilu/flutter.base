part of 'signup_cubit.dart';

@freezed
abstract class SignupState with _$SignupState {
  factory SignupState({
    required FullnameVos name,
    required FullnameVos lastName,
    required String email,
    required String password,
    required String repeatPassword,
    required bool showErrors,
    required ResultOr<SignUpFailure> resultOr,
  }) = _SignupState;

  factory SignupState.initial() => _SignupState(
    name: FullnameVos(''),
    lastName: FullnameVos(''),
    email: '',
    password: '',
    repeatPassword: '',
    showErrors: false,
    resultOr: ResultOr.none(),
  );

  SignupState._();

  EmailVos get emailVos => EmailVos(email);

  PasswordVos get passwordVos => PasswordVos(password);
}
