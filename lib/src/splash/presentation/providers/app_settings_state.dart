part of 'app_settings_cubit.dart';

@freezed
abstract class AppSettingsState with _$AppSettingsState {
  factory AppSettingsState({
    required Resource<FirebaseFailure, AppSettingsModel> resource,
  }) = _AppSettingsState;

  factory AppSettingsState.initial() => _AppSettingsState(
    resource: Resource.none(),
  );
}
