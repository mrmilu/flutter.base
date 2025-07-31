import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_mode_cubit.freezed.dart';
part 'theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(ThemeModeState.initial());

  void toggleTheme() {
    final isDarkMode = !state.isDarkMode;
    changeThemeMode(isDarkMode);
  }

  Future<void> changeThemeMode(bool isDarkMode) async {
    emit(state.copyWith(isDarkMode: isDarkMode));
  }
}
