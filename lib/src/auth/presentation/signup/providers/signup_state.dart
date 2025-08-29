part of 'signup_cubit.dart';

@freezed
abstract class SignupState with _$SignupState {
  factory SignupState({
    required String name,
    required String lastName,
    required String email,
    required String password,
    required String repeatPassword,
    required bool agreeTerms,
    required bool showErrors,
    required ResultOr<SignupFailure> resultOr,
  }) = _SignupState;

  factory SignupState.initial() => _SignupState(
    name: '',
    lastName: '',
    email: '',
    password: '',
    repeatPassword: '',
    agreeTerms: false,
    showErrors: false,
    resultOr: ResultOr.none(),
  );

  SignupState._();

  FullnameVos get nameVos => FullnameVos(name);

  FullnameVos get lastNameVos => FullnameVos(lastName);

  EmailVos get emailVos => EmailVos(email);

  PasswordVos get passwordVos => PasswordVos(password);
}
