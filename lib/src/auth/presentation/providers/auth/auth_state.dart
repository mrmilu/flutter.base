part of 'auth_cubit.dart';

@freezed
abstract class AuthState with _$AuthState {
  factory AuthState({
    required UserModel? user,
  }) = _AuthState;

  factory AuthState.initial() => _AuthState(
    user: null,
  );

  const AuthState._();

  bool get isAuthenticated => user != null;
}
