part of 'theme_mode_cubit.dart';

@freezed
abstract class ThemeModeState with _$ThemeModeState {
  factory ThemeModeState({
    required bool isDarkMode,
  }) = _ThemeModeState;

  factory ThemeModeState.initial() => _ThemeModeState(
    isDarkMode: false,
  );

  ThemeModeState._();
}
