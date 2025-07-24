part of 'required_password_cubit.dart';

@freezed
abstract class RequiredPasswordState with _$RequiredPasswordState {
  factory RequiredPasswordState({
    required String password,
    required ResultOr<RequiredPasswordFailure> resultOr,
  }) = _RequiredPasswordState;

  factory RequiredPasswordState.initial() => _RequiredPasswordState(
    password: '',
    resultOr: ResultOr.none(),
  );
}
