part of 'main_home_cubit.dart';

@freezed
abstract class MainHomeState with _$MainHomeState {
  factory MainHomeState({
    required Resource<UserEndpointError, List<String>> resourceGetProducts,
  }) = _MainHomeState;

  factory MainHomeState.initial() => _MainHomeState(
    resourceGetProducts: Resource.none(),
  );
}
