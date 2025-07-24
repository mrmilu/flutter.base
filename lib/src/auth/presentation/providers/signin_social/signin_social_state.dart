part of 'signin_social_cubit.dart';

@freezed
abstract class SigninSocialState with _$SigninSocialState {
  factory SigninSocialState({
    required ResultOr<OAuthSignInFailure> resultOr,
  }) = _SigninSocialState;

  factory SigninSocialState.initial() => _SigninSocialState(
    resultOr: ResultOr.none(),
  );
}
