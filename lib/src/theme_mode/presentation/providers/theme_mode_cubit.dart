import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/i_theme_mode_repository.dart';

part 'theme_mode_cubit.freezed.dart';
part 'theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  final IThemeModeRepository themeModeRepository;
  ThemeModeCubit({required this.themeModeRepository})
    : super(ThemeModeState.initial());

  Future<void> init() async {
    await loadThemeMode();
  }

  void toggleTheme() {
    final isDarkMode = !state.isDarkMode;
    changeThemeMode(isDarkMode);
  }

  Future<void> changeThemeMode(bool isDarkMode) async {
    await saveThemeMode(isDarkMode);
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  Future<void> loadThemeMode() async {
    final isDarkMode = await themeModeRepository.isDarkMode();
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  Future<void> saveThemeMode(bool isDarkMode) async {
    await themeModeRepository.saveThemeMode(isDarkMode);
  }
}
