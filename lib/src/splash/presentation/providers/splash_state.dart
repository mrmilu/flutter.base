part of 'splash_cubit.dart';

@freezed
abstract class SplashState with _$SplashState {
  factory SplashState({
    required bool canUpdate,
    required String progressText,
    required double progressValue,
    required bool splashIsLoaded,
    required bool readyToNavigate,
    required bool errorLoading,
    required ResultOr<SplashFailure> resultOrLoad,
    required String? token,
  }) = _SplashState;

  factory SplashState.initial() => _SplashState(
    canUpdate: false,
    progressText: '',
    progressValue: 0,
    splashIsLoaded: false,
    readyToNavigate: false,
    errorLoading: false,
    resultOrLoad: ResultOr.none(),
    token: null,
  );
}
